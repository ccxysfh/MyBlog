"""
Django settings for myblog project.

Generated by 'django-admin startproject' using Django 1.10.2.

For more information on this file, `
https://docs.djangoproject.com/en/1.10/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.10/ref/settings/
"""
# choose settings between Developement and Deploy
import os
import platform

node = platform.node()
print(node)
dev_machines = ('cheng-cx', 'cheng-cx.local')

if node in dev_machines:
    # folder My_Blog
    MyBlog = os.path.dirname(os.path.dirname(__file__))
    # project dir, contains static and media folder under DEV environment
    PROJECT_DIR = os.path.dirname(MyBlog)
    DEBUG =  True
    DATABASES = {
        'default': {
            # 'ENGINE': 'django.db.backends.sqlite3',
            # 'NAME': os.path.join(My_Blog, 'db.sqlite3'),
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'blogcx',
            'USER': 'root',
            'PASSWORD': '123456',
            'HOST': 'localhost',
            'PORT': '3306',
        }
    }
    STATIC_ROOT = os.path.join(PROJECT_DIR, 'static')
    STATIC_URL = '/static/'
    MEDIA_ROOT = os.path.join(PROJECT_DIR, 'media')
    MEDIA_URL = '/media/'
    TEMPLATE_DIRS = [os.path.join(MyBlog, 'templates')]
    ALLOWED_HOSTS = ['*']
else:
    DEBUG = False
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'blogcx',
            'USER': 'root',
            'PASSWORD': '123456',
            'HOST': '115.29.113.231',
            'PORT': '3306',
        }
    }
    PROJECT_DIR = '/root/Env/blog/MyBlog'
    MEDIA_ROOT = '/root/Env/blog/media/'
    MEDIA_URL = '/media/'
    STATIC_ROOT = '/root/Env/blog/static/'
    STATIC_URL = '/static/'

    STATICFILES_DIRS = (
        os.path.join(PROJECT_DIR, 'static'),
    )

    TEMPLATE_DIRS = (
        os.path.join(PROJECT_DIR, 'templates'),
    )

    ALLOWED_HOSTS = [
        '*',
    ]

    # # cache entire site
    # MIDDLEWARE_CLASSES_ADDITION_FIRST = (
    #     'django.middleware.cache.UpdateCacheMiddleware',
    # )

    # MIDDLEWARE_CLASSES_ADDITION_LAST = (
    #     'django.middleware.cache.FetchFromCacheMiddleware',
    # )

    # CACHES = {
    #     'default': {
    #         'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
    #         'LOCATION': '127.0.0.1:11211',
    #     }
    # }

