import os

import markdown2
from datetime import datetime
from django.core.files.base import ContentFile
from django.core.urlresolvers import reverse
from django.db import models, connection, connections, transaction
# delete md_file before delete/change model
from django.db.models.signals import pre_delete
from django.dispatch import receiver
# for slug, get_absolute_url
from django.template.defaultfilters import slugify
from taggit.managers import TaggableManager
from unidecode import unidecode

upload_dir = 'content/BlogPost/%s/%s'
import logging

logger = logging.getLogger("myblog.custom")


class BlogPost(models.Model):

    class Meta:
        ordering = ['-pub_date']    # ordered by pub_date descending when retriving

    def get_upload_md_name(self, filename):
        if self.pub_date:
            year = self.pub_date.year   # always store in pub_year folder
        else:
            year = datetime.now().year
        upload_to = upload_dir % (year, self.filename + '.md')
        return upload_to

    def get_html_name(self, filename):
        if self.pub_date:
            year = self.pub_date.year
        else:
            year = datetime.now().year
        upload_to = upload_dir % (year, self.filename + '.html')
        return upload_to

    CATEGORY_CHOICES = (
        ('ml', 'Machine Learning'),
        ('ani', 'Animation'),
        ('su', 'Summary'),
        ('programming', 'Programming'),
        ('acg', 'animation & summary & machine learning'),
        ('nc', 'No Category'),
        ('oth', 'Others'),
    )

    title = models.CharField(max_length=150)
    body = models.TextField(blank=True)
    md_file = models.FileField(upload_to=get_upload_md_name,
                               blank=True)  # uploaded md file, method 'upload_to' update filename
    pub_date = models.DateTimeField('date published', auto_now_add=True)
    last_edit_date = models.DateTimeField('last edited', auto_now=True)
    slug = models.SlugField(max_length=200, blank=True) #The post slug is the user friendly and URL valid name of a post.
    html_file = models.FileField(upload_to=get_html_name, blank=True)    # generated html file
    category = models.CharField(max_length=30, choices=CATEGORY_CHOICES)
    description = models.TextField(blank=True)
    tags = TaggableManager()

    def __str__(self):
        return self.title   # 根据继承搜索流程,先是实例属性,然后就是类属性,所以这样用没问题

    @property
    def filename(self):
        if self.title:
            return os.path.basename(self.title)
        else:
            return 'no md_file'

    def save(self, *args, **kwargs):
        self.slug = slugify(unidecode(self.title))
        if not self.body and self.md_file:
            self.body = self.md_file.read()

        self.save_body_to_html()

        super().save(*args, **kwargs)

    def save_body_to_html(self):
        html = markdown2.markdown(self.body,
                                  extras=["fenced-code-blocks", "tables", 'toc', 'code-friendly'])
        try:
            toc = html.toc_html
            html = toc + html
        except:
            pass
        self.html_file.save(self.title + '.html',
                            ContentFile(html.encode('utf-8')), save=False)
        self.html_file.close()

    def display_html(self):
        # if file not exists,create from bofy stored in db
        if not os.path.exists(self.html_file.path):
            self.save_body_to_html()

        with open(self.html_file.path, encoding='utf-8') as f:
            return f.read()

    def get_absolute_url(self):
        return reverse('blogpost_slug_id',
                       kwargs={'slug': self.slug, 'post_id': self.id})

    def get_api_absolute_url(self):
        return reverse('api_blogpost_slug_id',
                       kwargs={'slug': self.slug, 'post_id': self.id})


@receiver(pre_delete, sender=BlogPost)
def blogpost_delete(instance, **kwargs):
    if instance.md_file:
        instance.md_file.delete(save=False)
    if instance.html_file:
        instance.html_file.delete(save=False)


class BlogPostImage(models.Model):

    def get_upload_img_name(self, filename):
        upload_to = upload_dir % ('images', filename)  # filename involves extension
        return upload_to

    blogpost = models.ForeignKey(BlogPost, related_name='images')
    image = models.ImageField(upload_to=get_upload_img_name)

class BaseManage(models.Manager):
    # 根据传入属性dict生成增删改查的sql，使用raw方法进行查询，针对绑定了model的情况
    # 如果没有绑定model，也可以使用direct_xxxx_query_sqlVO传入得到的sqlVO进行查询
    __cursor = None

    def __init__(self):
        self.__cursor = connection.cursor()

    # TODO 提供真正的事务操作方法
    def identify_db(self, db_name):
        try:
            self.__cursor = connections[db_name].cursor()
        except Exception as e:
            logger.log(level=logging.INFO, msg='ERROR:[{e}]'.format(e=e))
    # 配置一个函数文档字符串模版吧 FIXED defm + tab
    def execute_single(self, sqlVO):
        """数据库查询的增删改底层操作
            sqlVO: a dict which contains 'sql', 'vars'
        :return: True if execute success or False if not.

        """
        try:
            self.__cursor.execute(sqlVO.get('sql'), sqlVO.get('vars', None))
        except Exception as e:
            logger.log(level=logging.INFO, mag='Failed to execute SQL[%s]\n' % sqlVO.get('sql'))
            logger.log(level=logging.INFO, msg="ERROR:[{e} ]".format(e=e))
            raise Exception(e) # 上层捕获异常，回滚事务
        else: # 若无异常执行else，该条语句返回True，不提交事务，最后上层调用提交事务
            return True

    def select_single(self, sqlVO):
        try:
            self.__cursor.execute(sqlVO.get('sql'), sqlVO.get('vars', None))
            return self.dictfetchall(self.__cursor)
        except Exception as e:
            logger.log(level=logging.INFO, mag='Failed to execute SQL[%s]\n' % sqlVO.get('sql'))
            logger.log(level=logging.INFO, msg="ERROR:[{e} ]".format(e=e))
            raise Exception(e)

    def select_single_tuple(self, sqlVO):
        try:
            self.__cursor.execute(sqlVO.get('sql'), sqlVO.get('vars', None))
            return self.__cursor.fetchall()
        except Exception as e:
            logger.log(level=logging.INFO, mag='Failed to execute SQL[%s]\n' % sqlVO.get('sql'))
            raise Exception(e)

def transaction_decorator(f):

    def wrapper(*args):
        bsm = None
        for arg in args:
            if isinstance(arg, BaseManage):
                bsm = arg
                break
        try:
            with transaction.atomic():
                f(bsm)
        except Exception as e:
            logger.log(level=logging.INFO, msg="transaction error！")
            logger.log(level=logging.INFO, msg="ERROR:[{e} ]".format(e=e))

    return wrapper

class TaekwondoPoomsae(models.Model):
    # TODO 品势字段设计，
    chapter = models.CharField(max_length=150)#一至八、高丽、金刚、太白
    action = models.CharField(max_length=150)# 对应动作在每章的序号
    sequence = models.IntegerField()
    actionsum = models.IntegerField()
    remark = models.CharField(max_length=750, blank=True)

class PoomsaeInfo(models.Model):
    chapter = models.CharField(max_length=150)  # 一至八、高丽、金刚、太白
    actionsum = models.IntegerField()
    leg = models.CharField(max_length=150) # 腿法
    foot = models.CharField(max_length=150) # 步法
    defence = models.CharField(max_length=150) # 防守动作
    attack = models.CharField(max_length=150) # 攻击动作
    meaning = models.CharField(max_length=750, blank=True) # 含义
