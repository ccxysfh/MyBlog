# Django+Nginx+uWSGI搭建博客  

网站界面已更新至第二版，一次偶然的机会看到<a href="http://blog.andrebarbosa.co/" target="_blank">**André Barbosa**</a>的博客，这种风格深深的打动了我，看到它的第一眼，我就意识到这正是我一直在找寻的风格，向André Barbosa致以我最诚挚的谢意。

界面样式基本采用<a href="http://blog.andrebarbosa.co/" target="_blank">**André Barbosa**</a>的博客，对细节交互进行了细微修改。另外感谢<a href="https://github.com/laike9m" target="_blank">**laike9m**</a>, laike9m开放在github上blog源码在逻辑上给予了我很大的帮助。

标签管理使用<a href="https://github.com/alex/django-taggit" target="_blank">**django-taggit**</a>.



## Setting up Django and your web server with uWSGI and nginx

[这是一个非常详尽的Django+uWSGI+nginx安装说明](https://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html)

项目启动前，需要到static file和media file进行组织,在最新的更新中，统一将static文件和media文件分别置于项目根目录的static_cdn和media中，static_cdn由django collectstatic动态组织，不上传到github进行版本管理，media文件进行版本管理并同步上传。

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



> 在下面提到的更新中，前端改用vue进行重新实现，很久没有学习关于前端的新东西了，因而记录一下vue的学习过程。

### vue实践

参见[web_gernal](./WebGernal.md)

## blog更新

> 20181119,界面ui调整，放弃django模版，前端采用vue.js

django后台提供数据接口，数据渲染在vue.js的script中实现

**修改数据库表：**

CREATE TABLE blog_blogpostimage LIKE css3template_blog_blogpostimage;

```
INSERT INTO blog_blogpostimage SELECT * FROM css3template_blog_blogpostimage;
INSERT INTO blog_blogpost SELECT * FROM css3template_blog_blogpost;
```



**更换pip源：**

```shell
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```

**更换npm镜像：**

```shell
# temp
npm --registry https://registry.npm.taobao.org install express
# persistent
npm config set registry https://registry.npm.taobao.org
# verify
npm config get registry or npm info express
# clear
npm config delete registry or npm config edit


```



> 20190412,blog结构调整及自动发布更新

use jupyter notebook to develop，install [Django-extensions](https://django-extensions.readthedocs.io/en/latest/installation_instructions.html)

use [djangorestframework](https://www.django-rest-framework.org/tutorial/quickstart/)for rest implement

> 20190413,blog迁移至新服务器，cicd集成

