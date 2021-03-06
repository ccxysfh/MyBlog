#!/usr/bin/env python
# encoding: utf-8

"""
@author: changxin.cheng
@mail: chengcx1019@gmail.com
@time: 2019-04-14 23:07
"""

from django.contrib.syndication.views import Feed

from .models import BlogPost


class LatestBlogpostsFeed(Feed):
	title = "Changxin's Blog"
	description = "Changxin's writing place"
	link = "/"

	def items(self):
		return BlogPost.objects.filter(show=1).order_by('-pub_date')[:5]

	def item_title(self, item):
		return item.title

	def item_description(self, item):
		return item.display_html()

	# item_link is only needed if NewsItem has no get_absolute_url method.
	def item_link(self, item):
		return item.get_feed_url()

	def get_context_data(self, **kwargs):
		context = super().get_context_data(**kwargs)
		context['text'] = "any way"
		return context


if __name__ == '__main__':
	pass
