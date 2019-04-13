"""myblog URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin

from blog_api import views

urlpatterns = [
    # admin
    url(r'^admin/', include(admin.site.urls)),

                  # blog_api
    url(r'^(?P<page>\d*)/$', views.home),
    url(r'^tag/(?P<tag>[-\w\d]+),(?P<page>\d+)?/$', views.tagdisplay, name='tagdisplay'),
    url(r'^$', views.home),
                  url(r'^blog/', include('blog_api.urls')),

    # computer_science_flash_cards
    url(r'^flash/',include('computer_science_flash_cards.urls')),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

handler404 = 'myblog.views.handler404'
