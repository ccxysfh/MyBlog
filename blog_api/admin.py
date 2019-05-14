import os

from django import forms
from django.conf import settings
from django.contrib import admin
from django.forms import TextInput, Textarea

from .models import BlogPost, BlogPostImage
from .views import save_blogpost


# Register your models here.

class BlogPostImageInline(admin.TabularInline):
    model = BlogPostImage
    extra = 3


class BlogPostAdminForm(forms.ModelForm):
    class Meta:
        model = BlogPost
        widgets = {
            'body': Textarea(attrs={'rows': 100, 'cols': 100}),
            'title': TextInput(attrs={'size': 40}),
        }
        exclude = ('html_file', 'md_file')


class BlogPostAdmin(admin.ModelAdmin):

    form = BlogPostAdminForm
    inlines = [BlogPostImageInline, ]

    @staticmethod
    def delete_old_md_file():
        # delete old md files, this method is unused now
        md_file_list = []
        for blogpost in BlogPost.objects.all():
            if blogpost.md_file:
                md_file_list.append(blogpost.filename)

        with open('md_file_list.txt', 'wt') as f:
            f.write(str(md_file_list))

        for root, subdirs, files in os.walk(os.path.join(settings.MEDIA_ROOT, 'content/BlogPost')):
            for file in files:
                if file not in md_file_list:
                    os.remove(os.path.join(root, file))

    def save_model(self, request, obj: BlogPost, form, change):
        # md
        save_blogpost(obj)


admin.site.register(BlogPost, BlogPostAdmin)