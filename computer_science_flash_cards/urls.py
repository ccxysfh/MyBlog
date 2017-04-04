from django.conf.urls import url, include
from . import views

urlpatterns = [
    url('^$', views.login),
    url('^login/$', views.login),
    url('^cards$', views.cards),
    url('^edit/?(P<card_id>\d+)$', views.edit),
    url('^edit_card$', views.edit_card),
    url('^filter_cards/(?P<filter_name>[-\w\d]+)$', views.filter_cards),
]
