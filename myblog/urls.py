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
from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.conf.urls.static import static
from django.conf import settings

# urlpatterns = [
#     # css3template_blog
#     url(r'^(?P<page>\d*)/$', 'css3template_blog.views.home'),
#     url(r'^$', 'css3template_blog.views.home'),
#     url(r'^blog/', include('css3template_blog.urls')),

#     # admin 
#     url(r'^admin/', include(admin.site.urls)),
#     # url(r'^referral/', 'my_blog.views.referral')
#     url(r'^flash/',include('computer_science_flash_cards.urls'))
# ]

urlpatterns = patterns(
    '',
    # css3template_blog
    url(r'^(?P<page>\d*)/$', 'css3template_blog.views.home'),
    url(r'^$', 'css3template_blog.views.home'),
    url(r'^blog/', include('css3template_blog.urls')),

    # admin 
    url(r'^admin/', include(admin.site.urls)),

    url(r'^flash/',include('computer_science_flash_cards.urls')),
) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

handler404 = 'myblog.views.handler404'
