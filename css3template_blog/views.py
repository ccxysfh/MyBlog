from collections import defaultdict
from math import ceil
from os.path import join

from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, Http404
from django.core.urlresolvers import reverse

from .models import BlogPost

exclude_posts = ("shares",)


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
        return render(request, 'css3template_blog/' + page_html, args)

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
    print(tag)
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
        ('programming', get_sorted_posts(category="programming")),
        ('ani', get_sorted_posts(category="ani")),
        ('ml', get_sorted_posts(category="ml")),
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
