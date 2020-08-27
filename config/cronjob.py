#!/usr/bin/env python
# encoding: utf-8

"""
@author: changxin.cheng
@mail: chengcx1019@gmail.com
@time: 2019-05-14 14:25
"""

import os
from time import strftime

import requests
from django.conf import settings
from lxml import html

from blog_api.models import BlogPost
from blog_api.views import get_remote_source, save_blogpost, remove_when_update
from config.settings import logger

PROJECT_DIR = settings.BASE_DIR
LOG_PATH = os.path.join(PROJECT_DIR, 'sql')

ext = ".md"

def getXpathTree(url):
    cont = requests.get(url)
    tree = html.fromstring(cont.content)
    return tree

base_url = "https://github.com"
url = "https://github.com/chengcx1019/universe/blob/master/writing/"
base_raw_url = "https://raw.githubusercontent.com"

def traverse_url(url):
    md_files = []
    tree = getXpathTree(url)
    files:list = tree.xpath('//table/tbody/tr[@class="js-navigation-item"]/td[@class="content"]/span/a[@class="js-navigation-open"]//@href')
    for f in files:
        if f.endswith(ext):
            md_files.append(f)
        else:
            md_files.extend(traverse_url(base_url+f))
    return md_files


def raw_url(md_file):
    path_segs = md_file.split('/')
    path_segs.remove('blob')
    return '/'.join(path_segs)


def get_raw_mds(md_files):
    return list(map(raw_url, md_files))


def trigger_update_blog():
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


def backup_sql():
    cmd_pattern = 'mysqldump -ublogcx -p789012 blogcx > {dir}/blogcx{time_str}.sql'
    dir_name = os.path.join(LOG_PATH, strftime('%Y%m'))
    if not os.path.exists(dir_name):
        os.makedirs(dir_name)
    cmd = cmd_pattern.format(dir=dir_name, time_str=strftime('%Y%m%d%H'))
    os.system(cmd)


if __name__ == '__main__':
    trigger_update_blog()
