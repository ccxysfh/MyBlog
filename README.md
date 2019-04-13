# Django+Nginx+uWSGI搭建博客  

网站界面已更新至第二版，一次偶然的机会看到<a href="http://blog.andrebarbosa.co/" target="_blank">**André Barbosa**</a>的博客，这种风格深深的打动了我，看到它的第一眼，我就意识到这正是我一直在找寻的风格，向André Barbosa致以我最诚挚的谢意。

界面样式基本采用<a href="http://blog.andrebarbosa.co/" target="_blank">**André Barbosa**</a>的博客，对细节交互进行了细微修改。另外感谢<a href="https://github.com/laike9m" target="_blank">**laike9m**</a>, laike9m开放在github上blog源码在逻辑上给予了我很大的帮助。

标签管理使用<a href="https://github.com/alex/django-taggit" target="_blank">**django-taggit**</a>.



## Setting up Django and your web server with uWSGI and nginx

[这是一个非常详尽的Django+uWSGI+nginx安装说明](https://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html)

项目启动前，需要到static file和media file进行组织

```
collect static files:
python manage.py collectstatic

pip install uwsgi  
将项目配置写入mysite_uwsgi.ini中，本项目参考uwsgi.ini  
uwsgi --ini mysite_uwsgi.ini  

网站的配置文件与nginx的配置文件连接，使nginx可以读取到相关配置  
ubuntu:
sudo ln -s /youtpath/managesys_nginx.conf  /etc/nginx/conf.d/ 
Mac OS X：
sudo ln -s  /yourpath/myblog_nginx.conf  /usr/local/etc/nginx/servers (nginx installed by homebrew)

Restart nginx:  
ubuntu:
sudo /etc/init.d/nginx restart
Max OS X:
sudo nginx -s stop && sudo nginx

```

 

## blog更新

>  20181119,界面ui调整，放弃django模版，前端采用vue.js

更换pip源：

```shell
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```
> 20190412,blog结构调整及自动发布更新

use jupyter notebook to develop，install [Django-extensions](https://django-extensions.readthedocs.io/en/latest/installation_instructions.html)

use [djangorestframework](https://www.django-rest-framework.org/tutorial/quickstart/)for rest implement

## start

```python
python manage.py runserver port
```

Before start you should migrate database change:

```python

python manage.py makemigrations
python manage.py migrate

```



**Note**
add your node_name in choose_settings.py's dev_machines, get node_name:

```shell
>>> import platform
>>> platform.node()
```




django后台提供数据接口，数据渲染在vue.js的script中实现

配合slack



> 插播一则想要学习的结构：湾区日报,下面是湾区日报的技术栈介绍。

主要用 Python/Django，Celery，RabbitMQ，Postgres 以及 Redis 搭建的。

对于湾区日报，Web App 就是 [Django](https://www.djangoproject.com/) App，用 [uwsgi](https://uwsgi-docs.readthedocs.org/en/latest/) 跑N个进程，用 [supervisord](http://supervisord.org/) 来管理进程，前面挂一个 [nginx](https://www.nginx.com/) 当 load balancer。Database用的是 [Postgres](http://www.postgresql.org/) 与 [Redis](http://redis.io/)  —  其中，大部分需要永久存储的数据都在Postgres中，而Redis存的是文章的访问数与一些只需保留一两天的数据。Task Queue是用 [RabbitMQ](http://www.rabbitmq.com/)。Scheduler用的是 [Celery Beat](http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html)。而Async Worker是 [Celery](http://docs.celeryproject.org/en/latest/index.html)。下图是湾区日报后台简单的架构



RSS订阅

今日计划

- 掌握vuex，解决blog的后台数据接口问题
- slack和hubot运维
- 改变blog的发布方式，随改随发，减少重复工作
- 采用docker进行组织，但我考虑可以分布进行
- 备份，回滚
- 快速过一下文档
- 每天的todo_list
- 每天github的提交有办法提高效率吗



我想记录一下自己是如何学习vue.js，似乎挺久没有学习新东西。

首先，将视频介绍里的vue的典型应用根据视频手敲出来，能对vue的数据传输有基本理解。之后按图索骥，把对语法有疑惑的地方标注出来，进一步阅读文档，例如，computed的作用时间，v-model和v-on的绑定机制等。

然而在此之前，我需要了解一个vue项目的加载流程

> 只有实例被创建时，data中存在的属性才是响应式的，如果你需要一个变量在之后才后用到，你可以先设置一个初始值

新建一个vue实例时，可以同时添加选项，大致可以分为三类：一是el，二是data，computed，watch， methods，props，三是生命周期钩子，后面找时间整理这些选项的意义，同时也必然需要掌握整个vue项目的加载流程，不然就没办法理解整个生命周期吧。

- computed计算属性

  对于任何复杂逻辑，你都应当使用**计算属性**

  ```js
  <div id="example">
    <p>Original message: "{{ message }}"</p>
    <p>Computed reversed message: "{{ reversedMessage }}"</p>
  </div>
  
  var vm = new Vue({
    el: '#example',
    data: {
      message: 'Hello'
    },
    computed: {
      // 计算属性的 getter
      reversedMessage: function () {
        // `this` 指向 vm 实例
        return this.message.split('').reverse().join('')
      }
    }
  })
  
  ```

  计算属性与方法的区别，结果是一样的，但是计算属性会根据依赖进行缓存，如果依赖没有发生变化，那么会立即返回之前的值，所以具体使用看需求，如果缓存不影响结果，那就定义计算属性。



组件注册，数值传递：**一个组件的 data 选项必须是一个函数**，因此每个实例可以维护一份被返回对象的独立的拷贝

prop有什么解释吗，只是作为一个传值的标志吗



vue生命周期

![](/media/files/images/vuelifecycle.png)



css优先级

 基本上，一个选择器越多特性，样式冲突的时候将显示它的样式。特性的计算规则如下：

- 使用ID选择器的值是100
- 使用class选择器的值是10
- 使用html选择器的值是1

它们加起来就可以计算出特性的值。





数据库备份及还原

CREATE TABLE blog_blogpostimage LIKE css3template_blog_blogpostimage;

```
INSERT INTO blog_blogpostimage SELECT * FROM css3template_blog_blogpostimage;
INSERT INTO blog_blogpost SELECT * FROM css3template_blog_blogpost;
```