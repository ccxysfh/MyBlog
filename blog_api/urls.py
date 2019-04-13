from django.conf.urls import url

from . import views

urlpatterns = [
    url('^$', views.home),
    url(r'^(?P<slug>[-\w\d]+),(?P<post_id>\d+)/$', views.blogpost, name='blogpost_slug_id'),
    url('^archive/$', views.archive),
    url('^shares/$', views.shares),
    url('^profile/$',views.profile),
    url('^happy_birthday_to_my_princess_huyao/$',views.happy_birthday),
    url('^happy_birthday_to_my_princess_huyao/$', views.happy_birthday),
    url('^api/allblogs/(?P<page>\d*)', views.api_allblogs),
    url('^api/tag/(?P<tag>[-\w\d]+),(?P<page>\d+)?/$', views.api_tagblog, name='api_tag'),
    url(r'^api/(?P<slug>[-\w\d]+),(?P<post_id>\d+)/$', views.api_blogpost, name='api_blogpost_slug_id'),
    url('^api/archive', views.api_archive, name='api_archive'),
    url('^api/shares', views.api_shares, name='api_shares'),
]
