import json
import logging
import platform
from collections import defaultdict
from datetime import datetime, timezone
from math import ceil
from multiprocessing.dummy import Pool as ThreadPool

from celery import shared_task
import redis
import requests
from django.conf import settings
from django.core import serializers
from django.core.files.base import ContentFile
from django.http import JsonResponse
from django.shortcuts import redirect, get_object_or_404
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.gzip import gzip_page
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

from .cache import generate_cache_key, generate_cache_key_id
from .models import BlogPost

seconds_of_day = 24 * 60 * 60

exclude_posts = ("shares","Happy Birthday To My Princess",)
logger = logging.getLogger("myblog.custom")

base_raw_url = "https://raw.githubusercontent.com"
repo_url = "/chengcx1019/universe/master/writing/"

METHOD_GET='GET'
METHOD_POST='POST'

try:
    pool = redis.ConnectionPool(max_connections=5, host=settings.REDIS_HOST, port=settings.REDIS_PORT, db=0)
    cache = redis.StrictRedis(connection_pool=pool)
except Exception as e:
    logger.error("connect redis error",e)

@gzip_page
def happy_birthday(request):
    args = dict()
    tag = "HappyBirthday"
    args['tag'] = tag
    blog_set = BlogPost.objects.filter(tags__name__in=[tag, ])
    if len(blog_set)>0:
        blogpost_json = entire_blogpost(blog_set[0])
        args['blogpost'] = blogpost_json
    return JsonResponse(args)


# api version
def args_generator(args, blogposts):
    blog_list = json.loads(serializers.serialize("json", blogposts))
    def process(arg):
        blog_query, index = arg
        blog_list[index]['content'] = blog_query.display_html()
        blog_list[index]['tags'] = json.loads(serializers.serialize("json", blog_query.tags.all()))
        blog_list[index]['url'] = blog_query.get_api_absolute_url()
    pool = ThreadPool()
    pool.map(process, zip(blogposts,[i for i in range(len(blogposts))]))
    pool.close()
    pool.join()

    args['blogposts'] = blog_list
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


def split_page(args, page):
    max_page = ceil(len(args['blogposts']) / 3)
    page = int(page) if (page and int(page) > 0) else 1
    args['page'] = page
    args['prev_page'] = page + 1 if page < max_page else None
    args['newer_page'] = page - 1 if page > 1 else None  # if page rows then the new_page is not none
    # as template slice filter, syntax: list|slice:"start:end"
    args['sl'] = str(3 * (page - 1)) + ':' + str(3 * (page - 1) + 3)
    args['max_page'] = max_page

@gzip_page
def api_allblogs(request, page=''):
    if page and int(page) < 2:  # /0, /1 -> /
        return redirect("/blog/api/allblogs/")

    blogposts_cache_key, args_str = get_cache_result_by_key("ALL")
    if args_str:
        args = json.loads(args_str)
        split_page(args, page)
        return JsonResponse(args)

    args = dict()
    blogposts = get_all_blogposts()
    args_generator(args, blogposts)
    split_page(args, page)
    try:
        cache.set(blogposts_cache_key, json.dumps(args, ensure_ascii=False), ex=seconds_of_day)
    except Exception as e:
        logger.warn("set tag cache fail", e)
    return JsonResponse(args)


def get_cache_result_by_key(key):
    all_blogposts_cache_key = generate_cache_key(key)
    args_str=None
    try:
        args_str = cache.get(all_blogposts_cache_key)
    except Exception as e:
        logger.info("get cache error")
    return all_blogposts_cache_key, args_str

@gzip_page
def api_tagblog(request, tag, page=''):
    if page and int(page) < 2:  # /0, /1 -> /
        return redirect(reverse('api_tag', kwargs={'tag': tag}))
    blogposts_cache_key, args_str = get_cache_result_by_key(tag)
    if args_str:
        args = json.loads(args_str)
        split_page(args, page)
        return JsonResponse(args)
    args = dict()
    args['tag'] = tag
    blogposts = BlogPost.objects.filter(tags__name__in=[tag, ]).filter(show=1)
    args_generator(args, blogposts)
    split_page(args, page)
    try:
        cache.set(blogposts_cache_key, json.dumps(args, ensure_ascii=False),ex=seconds_of_day)
    except Exception as e:
        logger.warn("set tag cache fail", e)
    return JsonResponse(args)

@gzip_page
def api_blogpost(request, slug, post_id):
    blogpost_cache_key = generate_cache_key_id("BLOG", post_id)
    args_str =None
    try:
        args_str = cache.get(blogpost_cache_key)
    except Exception as e:
        logger.info("get blogpost cache error:{blog_id}".format(blog_id=post_id))
    if args_str:
        return JsonResponse(json.loads(args_str))

    blogpost = get_object_or_404(BlogPost, pk=post_id)

    blogpost_json = entire_blogpost(blogpost)

    args = {'blogpost': blogpost_json}
    try:
        cache.set(blogpost_cache_key, json.dumps(args, ensure_ascii=False),ex=seconds_of_day)
    except Exception as e:
        logger.warn("set blog cache fail", e)
    return JsonResponse(args)

@gzip_page
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

    try:
        cache.set(blogposts_cache_key, json.dumps(args, ensure_ascii=False),ex=seconds_of_day)
    except Exception as e:
        logger.warn("set archive cache fail", e)

    return JsonResponse(args)



def get_all_blogposts():
    return BlogPost.objects.exclude(title__in=exclude_posts).filter(show=1)

@gzip_page
def api_shares(request):
    the_talks_post = get_object_or_404(BlogPost, title="shares")
    blogpost_json = entire_blogpost(the_talks_post)
    args = {"shares": blogpost_json}
    return JsonResponse(args)


@csrf_exempt
def api_blog_save(request):
    args = dict()
    if request.method == METHOD_POST:
        data = get_post_body(request)
        blog = BlogPost()

        repo_md_file = data.get("remote_source")
        blog_res = BlogPost.objects.filter(remote_source=repo_md_file)
        if len(blog_res)>0:
            args["result"] = "fail"
            args["desc"] = "blog with same remote source already existed"
            return JsonResponse(args)

        blog.title = data.get("title", "")
        blog.category = data.get("category", "programming")

        blog.remote_source = repo_md_file
        blog.body = get_remote_source(repo_md_file)
        blog.show=1
        try:
            save_blogpost(blog)
            args["result"] = "success"
            args['pk']=blog.pk
            tag = data.get("tag", "startup")
            list(map(blog.tags.add, tag.split(',')))
            remove_when_save(tag)
        except Exception as e:
            logger.info(e)
            description = "save blog body fail, remote_source:{repo_md_file}, check character first"\
                .format(repo_md_file=repo_md_file)
            logger.warn(description)
            args["result"] = "fail"
            args["desc"] = description
        return JsonResponse(args)


@csrf_exempt
def update_blog_properties_pk(request):
    if request.method == METHOD_POST:
        data = get_post_body(request)
        pk = data.get('pk', None)
        blog_res = BlogPost.objects.filter(pk=pk)
        args =blog_update_internal(blog_res, data)
        if 'fail' == args['result']:
            args['desc'] = 'please check pk'
        return JsonResponse(args)


@csrf_exempt
def update_blog_properties_source(request):
    if request.method == METHOD_POST:
        data = get_post_body(request)
        repo_md_file = data.get('remote_source')
        blog_res = BlogPost.objects.filter(remote_source=repo_md_file)
        args =blog_update_internal(blog_res, data)
        return JsonResponse(args)


def api_blog_trigger(request):
    # equal to update
    args = dict()
    if request.method == METHOD_GET:
        params = request.GET
        repo_md_file = params.get("remote_source")
        blog_res = BlogPost.objects.filter(remote_source=repo_md_file)
        if (len(blog_res)) > 0:
            blog = blog_res[0]
            blog.body = get_remote_source(repo_md_file)
            blog.remote_source = repo_md_file
            try:
                save_blogpost(blog)
                remove_when_update(blog.tags.all(), blog.pk)
                args['pk']=blog.pk
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

def trigger_auto(request):
    args = dict()
    trigger_update_blog.delay()
    args["result"] = "success"
    return JsonResponse(args)


@shared_task
def trigger_update_blog():
    logger.info("start")
    blogposts = BlogPost.objects.all()
    for blogpost in blogposts:
        remote_source = blogpost.remote_source
        if remote_source is not None and remote_source != "":
            try:
                blogpost.body = get_remote_source(remote_source)
                save_blogpost(blogpost)
                remove_when_update(blogpost.tags.all(), blogpost.pk)
            except Exception as e:
                logger.warn("blogpost:{id} update from {remote_source} fail,error detail:{err}"
                            .format(id=blogpost.id, remote_source=remote_source, err=e))
    return True

def remove_when_update(tags, post_id):
    try:
        all_blogposts_cache_key = generate_cache_key("ALL")
        cache.delete(all_blogposts_cache_key)
        blogpost_cache_key = generate_cache_key_id("BLOG", post_id)
        cache.delete(blogpost_cache_key)
        remove_tag_cache(tags)
    except Exception as e:
        logger.info(e)


def remove_tag_cache(tags):
    for tag in json.loads(serializers.serialize("json", tags)):
        try:
            tag_name = tag.get("fields").get("name")
            cache.delete(generate_cache_key(tag_name))
        except Exception as e:
            logger.info(tag, e)


def get_remote_source(repo_md_file):
    raw_url = base_raw_url + repo_url + repo_md_file
    status_force = (500, 502, 504)
    with requests.Session() as s:
        retry = Retry(connect=5, backoff_factor=0.5, status_forcelist=status_force)
        adapter = HTTPAdapter(max_retries=retry)
        s.mount('http://', adapter)
        s.mount('https://', adapter)
        res = s.get(raw_url)
    if not res.ok:
        raise Exception("connect refused")
    return res.text.strip()


def remove_when_save(tag):
    try:
        all_blogposts_cache_key = generate_cache_key("ALL")
        cache.delete(all_blogposts_cache_key)
        archive_blogposts_cache_key = generate_cache_key("ARCHIVE")
        cache.delete(archive_blogposts_cache_key)
        for t in tag.split(','):
            cache.delete(generate_cache_key(t))
    except Exception as e:
        logger.info(e)


def get_post_body(request):
    data = json.loads(request.body, encoding='utf-8')
    return data


def blog_update_internal(blog_res, data)->dict:
    args = dict()
    if len(blog_res) == 0:
        args["result"] = "fail"
        args["desc"] = "blog  not exist, please check"
        return  args
    blog = blog_res[0]
    blog_properties_update_process(blog, data)
    try:
        save_blogpost(blog)
        remove_when_update(blog.tags.all(), blog.pk)
        args['key'] = blog.pk
        args["result"] = "success"
    except Exception as e:
        logger.error(e)
        description = "update blog properties fail, check sentry for detail"
        logger.warn(description, e)
        args["result"] = "fail"
        args["desc"] = description
    return args


def blog_properties_update_process(blog:BlogPost, data):
    title = data.get('title', None)
    if title is not None:
        blog.title = title
    show = data.get('show', None)
    if show is not None:
        blog.show = show
    pub_date_timestamp = data.get('pub_date', None)
    if pub_date_timestamp:
        blog.pub_date = datetime.fromtimestamp(pub_date_timestamp, timezone.utc)
    category = data.get('category', None)
    if category is not None:
        blog.category = category

    repo_md_file = data.get("remote_source",None)
    if repo_md_file is not None:
        blog.remote_source = repo_md_file
    tags = data.get('tags', None)
    if tags is not None:
        tags = tags.split(',')
        if len(tags) > 0:
            remove_tag_cache(blog.tags.all())
            blog.tags.clear()
            for tag in tags:
                blog.tags.add(tag)


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

