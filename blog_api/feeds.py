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
	title = "recent 5 blogposts"
	description = "Updates on changes and additions to blog."
	link = "/"

	def items(self):
		return BlogPost.objects.order_by('-pub_date')[:5]

	def item_title(self, item):
		return item.title

	def item_description(self, item):
		return item.description

	# item_link is only needed if NewsItem has no get_absolute_url method.
	def item_link(self, item):
		return item.get_api_absolute_url()


if __name__ == '__main__':
	pass
