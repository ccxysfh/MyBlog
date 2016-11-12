from django.conf.urls import patterns, url, include
from . import views

urlpatterns = patterns(
    '',
    url('^$', views.login),
    url('^login/$', views.login),
    url('^cards$', views.cards),
)
