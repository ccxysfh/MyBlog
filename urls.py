from django.contrib import admin
from django.urls import include, path, re_path
from django.views.generic import TemplateView

urlpatterns = [
    # admin

    path('admin/', admin.site.urls),
    # blog_api
    path(r'blog/', include('blog_api.urls')),
    # computer_science_flash_cards
    # path(r'flash/', include('computer_science_flash_cards.urls')),
    re_path(r'^.*$', TemplateView.as_view(template_name='index.html')),

]
