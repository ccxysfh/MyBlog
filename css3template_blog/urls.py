from django.conf.urls import patterns, url, include
from . import views

urlpatterns = patterns(
    '',
    url('^$', views.home),
    url(r'^(?P<slug>[-\w\d]+),(?P<post_id>\d+)/$', views.blogpost),
    url('^archive/$', views.archive),
    url('^about/$', views.about),
    url('^projects/$', views.projects),
    url('^shares/$', views.shares),
    url('^article/(?P<freshness>.*)/$', views.article),  
)
