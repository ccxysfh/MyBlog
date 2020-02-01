import json
import logging
import platform
from collections import defaultdict
from math import ceil

import requests
from django.core import serializers
from django.conf import settings
from django.core.files.base import ContentFile
from django.http import HttpResponse, Http404, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
import redis

from .models import BlogPost
from .cache import generate_cache_key, generate_cache_key_id

exclude_posts = ("shares","Happy Birthday To My Princess",)
logger = logging.getLogger("myblog.custom")

cache = redis.StrictRedis(host=settings.REDIS_HOST,
                                  port=settings.REDIS_PORT, db=0)

# Create your views here.
def home(request,page_html='newlayout/index.html',page=''):
    args = dict()
    args['blogposts'] = BlogPost.objects.exclude(title__in=exclude_posts)
    args['blogpostsnum'] = len(args['blogposts'])
    max_page = ceil(len(args['blogposts']) / 3)
    if page and int(page) < 2:  # /0, /1 -> /
        return redirect("/")
    else:
        page = int(page) if (page and int(page) > 0) else 1
        args['page'] = page
        args['prev_page'] = page + 1 if page < max_page else None
        args['newer_page'] = page - 1 if page > 1 else None
        # as template slice filter, syntax: list|slice:"start:end"
        args['sl'] = str(3 * (page - 1)) + ':' + str(3 * (page - 1) + 3)
        args['max_page'] = max_page
        return render(request, 'blog_api/' + page_html, args)

def profile(request):
    return home(request,page_html='newlayout/profile.html')

def blogpost(request, slug, post_id):
    try:
        current_page = request.GET["current_page"]
    except:
        current_page = None
    try:
        tag = request.GET["tag"]
    except:
        tag = None
    args = {'blogpost': get_object_or_404(BlogPost, pk=post_id)}
    args['current_page'] = current_page
    args['tag'] = tag
    return render(request, 'css3template_blog/newlayout/blogpost.html', args)

def tagdisplay(request, tag, page=''):
    args = dict()
    logger.log(level=logging.INFO, msg="{tag}".format(tag=tag))
    args['tag'] = tag
    args['blogposts'] = BlogPost.objects.filter(tags__name__in=[tag,])
    args['blogpostsnum'] = len(args['blogposts'])
    max_page = ceil(len(args['blogposts']) / 3)
    if (page and int(page) < 2) or (page and int(page) > max_page):  # /0, /1 -> /
        return redirect(reverse('tagdisplay',kwargs={'tag':tag}))
    else:
        page = int(page) if (page and int(page) > 0) else 1
        args['page'] = page
        args['prev_page'] = page + 1 if page < max_page else None
        args['newer_page'] = page - 1 if page > 1 else None
        # as template slice filter, syntax: list|slice:"start:end"
        args['sl'] = str(3 * (page - 1)) + ':' + str(3 * (page - 1) + 3)
        args['max_page'] = max_page
    return render(request, 'css3template_blog/newlayout/tagdisplay.html', args)

def archive(request):
    args = dict()
    blogposts = BlogPost.objects.exclude(title__in=exclude_posts)

    def get_sorted_posts(category):
        posts_by_year = defaultdict(list)
        posts_of_a_category = blogposts.filter(category=category)  # already sorted by pub_date
        for post in posts_of_a_category:
            year = post.pub_date.year
            posts_by_year[year].append(post)  # {'2013':post_list, '2014':post_list}
        posts_by_year = sorted(posts_by_year.items(), reverse=True)  # [('2014',post_list), ('2013',post_list)]
        return posts_by_year

    args['data'] = [
        ('ml', get_sorted_posts(category="ml")),
        ('ani', get_sorted_posts(category="ani")),
        ('programming', get_sorted_posts(category="programming")),
        ('su', get_sorted_posts(category="su")),
        ('oth', get_sorted_posts(category="oth")),
    ]
    return render(request, 'css3template_blog/newlayout/archive.html', args)


def about(request):
    the_about_post = get_object_or_404(BlogPost, title="about")
    args = {"about": the_about_post}
    return render(request, 'css3template_blog/about.html', args)


def projects(request):
    # use markdown to show projects
    the_projects_post = get_object_or_404(BlogPost, title="projects")
    args = {"projects": the_projects_post}
    return render(request, 'css3template_blog/projects.html', args)


def shares(request):
    # use markdown to show talks, could be changed if need better formatting
    the_talks_post = get_object_or_404(BlogPost, title="shares")
    args = {"shares": the_talks_post}
    return render(request, 'css3template_blog/newlayout/share.html', args)


def contact(request):
    html = "<meta http-equiv=\"refresh\" content=\"3;url=" \
           "/\">Under Development. Will return to homepage."
    return HttpResponse(html)


def article(request, freshness):
    """ redirect to article accroding to freshness, latest->oldest:freshness=1->N """
    if freshness.isdigit():
        try:
            article_url = BlogPost.objects.all()[int(freshness) - 1].get_absolute_url()
            return redirect(article_url)
        except IndexError:
            raise Http404
        except AssertionError:  # freshness=0
            raise Http404
    else:
        return redirect('/')

def happy_birthday(request):
    args = dict()
    tag = "HappyBirthday"
    args['tag'] = tag
    args['blogposts'] = BlogPost.objects.filter(tags__name__in=[tag, ])
    return render(request, 'css3template_blog/newlayout/birthday.html', args)


# api version
def args_generator(args, blogposts):
    contents = [blogquery.display_html() for blogquery in blogposts]
    urls = [blogquery.get_api_absolute_url() for blogquery in blogposts]
    alltags = [blogquery.tags.all() for blogquery in blogposts]
    bolgList = json.loads(serializers.serialize("json", blogposts))

    for index in range(len(bolgList)):
        bolgList[index]['content'] = contents[index]
        bolgList[index]['tags'] = json.loads(serializers.serialize("json", alltags[index]))
        bolgList[index]['url'] = urls[index]
    args['blogposts'] = bolgList
    args['blogpostsnum'] = len(args['blogposts'])


def entire_blogpost(blogpost):
    content = blogpost.display_html()
    url = blogpost.get_api_absolute_url()
    alltags = blogpost.tags.all()
    blogpost_json = json.loads(serializers.serialize("json", [blogpost]))
    blogpost_json = blogpost_json[0]
    blogpost_json['content'] = content
    blogpost_json['url'] = url
    blogpost_json['tags'] = json.loads(serializers.serialize("json", alltags))
    return blogpost_json


def split_page(args, blogposts, page):
    max_page = ceil(len(args['blogposts']) / 3)
    page = int(page) if (page and int(page) > 0) else 1
    args['page'] = page
    args['prev_page'] = page + 1 if page < max_page else None
    args['newer_page'] = page - 1 if page > 1 else None  # if page rows then the new_page is not none
    # as template slice filter, syntax: list|slice:"start:end"
    args['sl'] = str(3 * (page - 1)) + ':' + str(3 * (page - 1) + 3)
    args['max_page'] = max_page


def api_allblogs(request, page=''):
    blogposts_cache_key, args_str = get_cache_result_by_key("ALL")
    if args_str:
        return JsonResponse(json.loads(args_str))
    args = dict()

    blogposts = get_all_blogposts()
    args_generator(args, blogposts)

    if page and int(page) < 2:  # /0, /1 -> /
        return redirect("/blog/api/allblogs/")
    else:
        split_page(args, blogposts, page)
        # return render(request, 'blog_api/' + page_html, args)
        cache.set(blogposts_cache_key, json.dumps(args,ensure_ascii=False))
        return JsonResponse(args)


def get_cache_result_by_key(key):
    all_blogposts_cache_key = generate_cache_key(key)
    try:
        args_str = cache.get(all_blogposts_cache_key)
    except Exception as e:
        logger.info("get cache error")
    return all_blogposts_cache_key, args_str


def api_tagblog(request, tag, page=''):
    blogposts_cache_key, args_str = get_cache_result_by_key(tag)
    if args_str:
        return JsonResponse(json.loads(args_str))
    args = dict()
    args['tag'] = tag
    blogposts = BlogPost.objects.filter(tags__name__in=[tag, ]).filter(show=1)
    args_generator(args, blogposts)

    if page and int(page) < 2:  # /0, /1 -> /
        return redirect(reverse('api_tag', kwargs={'tag': tag}))
    else:
        split_page(args, blogposts, page)
        cache.set(blogposts_cache_key, json.dumps(args, ensure_ascii=False))
        return JsonResponse(args)


def api_blogpost(request, slug, post_id):
    blogpost_cache_key = generate_cache_key_id("blig", post_id)
    try:
        args_str = cache.get(blogpost_cache_key)
    except Exception as e:
        logger.info("get blogpost cache error:{blog_id}".format(blog_id=post_id))
    if args_str:
        return JsonResponse(json.loads(args_str))

    blogpost = get_object_or_404(BlogPost, pk=post_id)

    blogpost_json = entire_blogpost(blogpost)

    args = {'blogpost': blogpost_json}
    cache.set(blogpost_cache_key, json.dumps(args, ensure_ascii=False))
    return JsonResponse(args)


def api_archive(request):
    blogposts_cache_key, args_str = get_cache_result_by_key("ARCHIVE")
    if args_str:
        return JsonResponse(json.loads(args_str))

    args = dict()
    blogposts = get_all_blogposts()

    def get_sorted_posts(category):
        posts_by_year = defaultdict(list)
        posts_of_a_category = blogposts.filter(category=category)  # already sorted by pub_date
        for post in posts_of_a_category:
            year = post.pub_date.year
            blogpost_json = entire_blogpost(post)
            posts_by_year[year].append(blogpost_json)  # {'2013':post_list, '2014':post_list}
        posts_by_year = sorted(posts_by_year.items(), reverse=True)  # [('2014',post_list), ('2013',post_list)]
        return posts_by_year

    args['data'] = [
        ('programming', get_sorted_posts(category="programming")),
        ('ml', get_sorted_posts(category="ml")),
        ('su', get_sorted_posts(category="su")),
        ('oth', get_sorted_posts(category="oth")),
        ('ani', get_sorted_posts(category="ani")),
    ]
    cache.set(blogposts_cache_key, json.dumps(args, ensure_ascii=False))
    return JsonResponse(args)

def get_all_blogposts():
    return BlogPost.objects.exclude(title__in=exclude_posts).filter(show=1)


def api_shares(request):
    the_talks_post = get_object_or_404(BlogPost, title="shares")
    blogpost_json = entire_blogpost(the_talks_post)
    args = {"shares": blogpost_json}
    return JsonResponse(args)


base_raw_url = "https://raw.githubusercontent.com"
repo_url = "/chengcx1019/universe/master/writing/"


def api_blog_save(request):
    args = dict()
    if request.method == "GET":
        params = request.GET
        blog = BlogPost()

        blog.title = params.get("title", "")
        blog.category = params.get("category", "programming")
        repo_md_file = params.get("remote_source")
        blog.remote_source = repo_md_file
        blog.body = get_remote_source(repo_md_file)
        blog.show=1
        try:
            save_blogpost(blog)
            args["result"] = "success"
        except Exception as e:
            logger.info(e)
            description = "save blog body fail, remote_source:{repo_md_file}, check character first".format(
                repo_md_file)
            logger.warn(description)
            args["result"] = "fail"
            args["desc"] = description
        save_blogpost(blog)
        tag = params.get("tag", "start_up")
        list(map(blog.tags.add, tag.split(',')))
        remove_when_save(tag)
        args["result"] = "success"
        return JsonResponse(args)


def remove_when_save(tag):
    all_blogposts_cache_key = generate_cache_key("ALL")
    cache.delete(all_blogposts_cache_key)
    archive_blogposts_cache_key = generate_cache_key("ARCHIVE")
    cache.delete(archive_blogposts_cache_key)
    for t in tag.split(','):
        cache.delete(generate_cache_key(t))


def api_blog_trigger(request):
    # equal to update
    args = dict()
    if request.method == "GET":
        params = request.GET
        repo_md_file = params.get("remote_source")
        blog_res = BlogPost.objects.filter(remote_source=repo_md_file)
        if (len(blog_res)) > 0:
            blog = blog_res[0]
            blog.body = get_remote_source(repo_md_file)
            blog.remote_source = repo_md_file
            try:
                save_blogpost(blog)
                remove_when_update(blog.tags.all())
                args["result"] = "success"
            except Exception as e:
                description = "update blog body fail, remote_source:{repo_md_file}, check character first".format(
                    repo_md_file)
                logger.warn(description)
                args["result"] = "fail"
                args["desc"] = description
                return JsonResponse(args)
        else:
            args["result"] = "fail"
            args["desc"] = "no such blog with remote source {repo_md_file}".format(repo_md_file=repo_md_file)
        return JsonResponse(args)


def remove_when_update(tags):
    all_blogposts_cache_key = generate_cache_key("ALL")
    cache.delete(all_blogposts_cache_key)
    for tag in json.loads(serializers.serialize("json", tags)):
        try:
            tag_name = tag.get("fields").get("name")
            cache.delete(generate_cache_key(tag_name))
        except Exception as e:
            logger.info(tag,e)


def get_remote_source(repo_md_file):
    raw_url = base_raw_url + repo_url + repo_md_file
    res = requests.get(raw_url)
    return res.text.strip()


def save_blogpost(obj):
    if obj:
        if obj.body:  # body有内容的时候才会更新md_file
            filename = obj.filename
            if filename != 'no md_file':
                # On Windows file can't be removed so leave it
                if platform.system() == "Windows":
                    pass
                else:
                    obj.md_file.delete(save=False)  # 部署的时候存在,可以正常删除文件
                    obj.html_file.delete(save=False)
            # 没有md_file就根据title创建一个, 但不能创建html因为obj.save()的时候会创建
            obj.md_file.save(filename + '.md', ContentFile(obj.body), save=False)
            obj.md_file.close()
    obj.save()
