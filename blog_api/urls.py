from django.urls import path

from blog_api import feeds
from . import views

urlpatterns = [
    # url('^$', views.home),
    # url(r'^(?P<slug>[-\w\d]+),(?P<post_id>\d+)/$', views.blogpost, name='blogpost_slug_id'),
    # url('^archive/$', views.archive),
    # url('^shares/$', views.shares),
    # url('^profile/$',views.profile),
    path('feed/', feeds.LatestBlogpostsFeed()),
    # url('^happy_birthday_to_my_princess_huyao/$',views.happy_birthday),
    # url('^happy_birthday_to_my_princess_huyao/$', views.happy_birthday),
    path('api/allblogs/', views.api_allblogs),
    path('api/allblogs/<str:page>', views.api_allblogs),
    path('api/tag/<str:tag>,<str:page>/', views.api_tagblog, name='api_tag'),
    path('api/<str:slug>,<str:post_id>/', views.api_blogpost, name='api_blogpost_slug_id'),
    path('api/archive/', views.api_archive, name='api_archive'),
    path('api/shares', views.api_shares, name='api_shares'),
]
