from django.conf.urls import url, include
from . import views

urlpatterns = [
    url('^$', views.home),
    url(r'^(?P<slug>[-\w\d]+),(?P<post_id>\d+)/$', views.blogpost, name='blogpost_slug_id'),
    url('^archive/$', views.archive),
    url('^shares/$', views.shares),
    url('^profile/$',views.profile),
    url('^happy_birthday_to_my_princess_huyao/$',views.happy_birthday),
]
