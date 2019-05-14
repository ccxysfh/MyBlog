#!/usr/bin/env python
# encoding: utf-8

"""
@author: changxin.cheng
@mail: chengcx1019@gmail.com
@time: 2019-05-14 14:25
"""
import os

import requests
from lxml import html

ext = ".md"

def getXpathTree(url):
    cont = requests.get(url)
    tree = html.fromstring(cont.content)
    return tree

base_url = "https://github.com"
url = "https://github.com/chengcx1019/architecture/blob/master/writing/"
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


# 拉取所有的blogpost，更具扩展url更新body，每次获取display_html时，都从body重新生成

if __name__ == '__main__':
    pass
