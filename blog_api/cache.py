#!/usr/bin/env python
# encoding: utf-8

"""
@author: changxin
@mail: chengcx1019@gmail.com
@file: cache.py
@time: 2020/2/1 23:33
"""
APP_PREFIX="BLOG_API"

def generate_cache_key(key):
    return APP_PREFIX +"_"+key

def generate_cache_key_id(key, id):
    return APP_PREFIX +"_"+key+"_"+ str(id)

if __name__ == '__main__':
    import os
