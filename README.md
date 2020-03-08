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
sudo ln -s /data/myblog/myblog_nginx.conf  /etc/nginx/sites-enabled/ 
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



> 20190412,blog结构调整

use jupyter notebook to develop，install [Django-extensions](https://django-extensions.readthedocs.io/en/latest/installation_instructions.html)

use [djangorestframework](https://www.django-rest-framework.org/tutorial/quickstart/)for rest implement

> 20190413,blog迁移至新服务器

由于阿里云服务到期，更换至其他服务器

> 20190422,增加ssl

**证书文件说明**

- .key 文件是证书私钥文件，如果申请证书时没有选择系统创建CSR，则没有该文件。此时该私钥文件由您自己保管。

- .crt 文件是证书文件，一般包含两段内容。如果是Apache服务器，会将证书文件拆分成 _public.crt(证书)文件和_chain.crt（证书链或中间证书）文件。

- .pem 文件是证书文件，一般包含两段内容。一般Nginx的一些文档会用该扩展名文件，在阿里云证书中与.crt文件一样。

  **友情提示**： **.crt**扩展名的证书文件采用Base64-encoded的PEM格式**文本文件**，可根据需要，修改成**.pem**等扩展名。

- .pfx 文件，一般适合Tomcat/IIS服务器；每次下载都会产生新密码，该密码仅匹配本次下载的证书。如果需要更新证书文件，同时也要更新密码。

**在nginx服务上安装SSL证书**

- 修改配置文件

**使用[Let's Encrypt](https://letsencrypt.org/getting-started/)生成证书**

[certbot](https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx)

证书文件路径：`/etc/letsencrypt`



> 20190514, 更新自动发布

自动从repo拉取所有文件，扩展字段存储相对于writing的路径

> 20190514, 增加私人助理jarvis

通过与私人助理jarvis([hubot](https://hubot.github.com/))对话发布和更新blog，以slack模式启动jarvis

```shell
./bin/hubot HUBOT_SLACK_TOKEN=xoxb-222935299232-625500868769-PNwj9Nxqta7akMJ5EaQztO4P --adapter slack
```



> 20190515, 增加定时任务，定时从git repo拉取blog更新

使用参考[django-crontab](https://pypi.org/project/django-crontab/)，注意需要在部署项目时执行`python manage.py crontab add`添加定时任务至系统：

```shell
# run this command to add all defined jobs from CRONJOBS to crontab
python manage.py crontab add
# show current active jobs of this project:
python manage.py crontab show
# removing all defined jobs is straight forward
python manage.py crontab remove
```

**定时任务时间设置说明**：

表示的核心就是用'* * * * *'表示循环执行的时间，分别代表“分(0-59)时(0-23)日(1-31)月(1-12,or Jan,Feb...)周(0-7,0or7=Sun.)”，后面表示具体执行的操作。

可循环的时间为分钟、 小 时、 每 周、 每月或每年等。

练习时间，以下分别表示什么时间呢，答案在最后^_^

```
59 23 3 7 *
59 21 * * 5
59 23 3 7 5
```

几个例子来说明时间的定义：

| 特殊字符 | 代表意义                                                     |
| -------- | :----------------------------------------------------------- |
| *(星号)  | 代表任何时刻都接受的意思！举例来说，范例一内那个日、月、周都是* ， 就代表着『不论何月、何日的礼拜几的12:00 都执行后续指令』的意思！ |
| ,(逗号)  | 代表分隔时段的意思。举例来说，如果要下达的工作是3:00 与6:00 时，就会是：0 3,6 * * * command时间参数还是有五栏，不过第二栏是3,6 ，代表3 与6 都适用！ |
| -(减号)  | 代表一段时间范围内，举例来说， 8 点到12 点之间的每小时的20 分都进行一项工作：20 8-12 * * * command仔细看到第二栏变成8-12 喔！代表8,9,10,11,12 都适用的意思！ |
| /n(斜线) | 那个n 代表数字，亦即是『每隔n 单位间隔』的意思，例如每五分钟进行一次，则：*/5 * * * * command很简单吧！用* 与/5 来搭配，也可以写成0-59/5 ，相同意思！ |


答案：

```
1. 今天是同学生日，所以你在7月3日23:59给自己预定了一个闹钟，每年的7月3日23:59都会有这个闹钟来提醒你
2. 你约好了朋友每周六去爬山，所以你会在每个周五的21:59给朋友发出提醒，让他们不要忘了明天的约定
3. 你一定会以为是7月3日且必须是周五的23:59才会执行操作，其实不会，系统会以为是7月3日，也可能会以为是周五才执行操作，这样行为就变得不可控了，因而日月和星期不可同时指定。
```



> 日月和星期不可同时指定。
>
> 更多详情参考[django-crontab Github](https://github.com/kraiz/django-crontab)和[鸟哥的linux私房菜](http://linux.vbird.org/linux_basic/0430cron.php#cron)。



> 20190530 更新公式加载异常的问题

加载异常的原因：ajax请求与数据返回是异步的，即发起请求后未等待数据返回就开始渲染组件，此时需要的数据还未初始化，但已执行mathjax渲染过程，导致了最终的公式显示异常。

期间需要更新npm依赖，需要将个别package更新到更新版本：`npm install {package_name}@latest` or `npm install {package_name}@next`.

如果需要重建工程，为了保持一致性，需要采取和之前一致的方式（不一致可能会出现意料之外的幺蛾子），`vue init webpack front`,vue升级到3.X之后可能会不太一致，请参考[Vue CLI](https://cli.vuejs.org/guide/creating-a-project.html#Pulling%202.x%20Templates%20(Legacy)).

安装chromedriver经常会超时,建议:`npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver `.

> 后续待优化的内容，jarvis命令自动化发布，页面链接及代码等样式的修复问题，vue依赖docker化



> 20190702 增加sentry监控



> 20191215 补充路由说明

为了快速实现并迭代，考虑增加量化投资子项目，因而需要增加额外的路由；目前路由分两个层次，一是django自身的路由，二是vue的路由，需要将vue的路由放在最后，并将路由模式设置为history，否则进入vue的某个路由的路径后，直接回车访问url会导致页面不可访问



> 20200307 提供jarvis操作更新

当发生http到https的重定向时，Post方法会变转发为Get方法，因而需要需要直接访问https路由进行post访问



> 20200408 vue中数据异步加载导致的dom加载响应异常，及async await在vue中的应用

这里有一种比较的情况，一是dom显示已加载完，绑定在mounted hook上的方法已经开始执行，但是实际需要的组件其实并未加载，这是由于异步的数据没有响应，还有新的组件未渲染，需要二次响应dom加载完成事件，目前的一个补偿措施是在watch hook上加上对异步数据的监控，等待数据ready后，设置一个超时等待方法检测dom加载完成事件，并执行对真正需要模块的操作，这部分是因为数据好后，组件渲染及加载需要时间，这个时间间隔无法控制，只能使用超时等待的方式处理。



async await使用来进行同步控制的，在使用ajax请求时，方法并未等待`this.$http.get`方法返回，外部方法就已经返回，打断了内部方法的正常响应结果，因而需要进行同步控制，在vue中参考示例如下：

```vue
export default {
  name: 'birthday',
  components: {
  },
 methods: {
    async getBlogPost() {
      let url = '/blog/xxxx'
      let reqUrl = this.$store.state.baseUrl + url
      console.log(reqUrl)
      let self = this
      await this.$http.get(reqUrl)
        .then((response) => {
          var res = JSON.parse(response.bodyText)
          self.blogpost = res.blogpost
        })
    }
」
```

这次的问题起因是在vue中引入echarts，最基本的dom引用一直无法成功，按照vue的文档，在mounted阶段，dom应该已经加载成功了，但是实际情况并不如预期，事实上存在二次加载的情况，文档也没有错，只是这次的情况比较特殊。

另外有一点需要注意的是，在多层闭包里，需要注意不同作用域内this的含义已经变化，需要在内层作用域使用的话，需要在外层转换下名称以便在内部作用域使用。

```json
        var china_geoCoordForSpecialMap = {
                      '上海': [121.4648,31.2891],
                      '东莞': [113.8953,22.901],
                      '东营': [118.7073,37.5513],
                      '中山': [113.4229,22.478],
                      '临汾': [111.4783,36.1615],
                      '临沂': [118.3118,35.2936],
                      '丹东': [124.541,40.4242],
                      '丽水': [119.5642,28.1854],
                      '乌鲁木齐': [87.9236,43.5883],
                      '佛山': [112.8955,23.1097],
                      '保定': [115.0488,39.0948],
                      '兰州': [103.5901,36.3043],
                      '包头': [110.3467,41.4899],
                      '北京': [116.4551,40.2539],
                      '北海': [109.314,21.6211],
                      '南京': [118.8062,31.9208],
                      '南宁': [108.479,23.1152],
                      '南昌': [116.0046,28.6633],
                      '南通': [121.1023,32.1625],
                      '厦门': [118.1689,24.6478],
                      '台州': [121.1353,28.6688],
                      '合肥': [117.29,32.0581],
                      '呼和浩特': [111.4124,40.4901],
                      '咸阳': [108.4131,34.8706],
                      '哈尔滨': [127.9688,45.368],
                      '唐山': [118.4766,39.6826],
                      '嘉兴': [120.9155,30.6354],
                      '大同': [113.7854,39.8035],
                      '大连': [122.2229,39.4409],
                      '天津': [117.4219,39.4189],
                      '太原': [112.3352,37.9413],
                      '威海': [121.9482,37.1393],
                      '宁波': [121.5967,29.6466],
                      '宝鸡': [107.1826,34.3433],
                      '宿迁': [118.5535,33.7775],
                      '常州': [119.4543,31.5582],
                      '广州': [113.5107,23.2196],
                      '廊坊': [116.521,39.0509],
                      '延安': [109.1052,36.4252],
                      '张家口': [115.1477,40.8527],
                      '徐州': [117.5208,34.3268],
                      '德州': [116.6858,37.2107],
                      '惠州': [114.6204,23.1647],
                      '成都': [103.9526,30.7617],
                      '扬州': [119.4653,32.8162],
                      '承德': [117.5757,41.4075],
                      '拉萨': [91.1865,30.1465],
                      '无锡': [120.3442,31.5527],
                      '日照': [119.2786,35.5023],
                      '昆明': [102.9199,25.4663],
                      '杭州': [119.5313,29.8773],
                      '枣庄': [117.323,34.8926],
                      '柳州': [109.3799,24.9774],
                      '株洲': [113.5327,27.0319],
                      '武汉': [114.3896,30.6628],
                      '汕头': [117.1692,23.3405],
                      '江门': [112.6318,22.1484],
                      '沈阳': [123.1238,42.1216],
                      '沧州': [116.8286,38.2104],
                      '河源': [114.917,23.9722],
                      '泉州': [118.3228,25.1147],
                      '泰安': [117.0264,36.0516],
                      '泰州': [120.0586,32.5525],
                      '济南': [117.1582,36.8701],
                      '济宁': [116.8286,35.3375],
                      '海口': [110.3893,19.8516],
                      '淄博': [118.0371,36.6064],
                      '淮安': [118.927,33.4039],
                      '深圳': [114.5435,22.5439],
                      '清远': [112.9175,24.3292],
                      '温州': [120.498,27.8119],
                      '渭南': [109.7864,35.0299],
                      '湖州': [119.8608,30.7782],
                      '湘潭': [112.5439,27.7075],
                      '滨州': [117.8174,37.4963],
                      '潍坊': [119.0918,36.524],
                      '烟台': [120.7397,37.5128],
                      '玉溪': [101.9312,23.8898],
                      '珠海': [113.7305,22.1155],
                      '盐城': [120.2234,33.5577],
                      '盘锦': [121.9482,41.0449],
                      '石家庄': [114.4995,38.1006],
                      '福州': [119.4543,25.9222],
                      '秦皇岛': [119.2126,40.0232],
                      '绍兴': [120.564,29.7565],
                      '聊城': [115.9167,36.4032],
                      '肇庆': [112.1265,23.5822],
                      '舟山': [122.2559,30.2234],
                      '苏州': [120.6519,31.3989],
                      '莱芜': [117.6526,36.2714],
                      '菏泽': [115.6201,35.2057],
                      '营口': [122.4316,40.4297],
                      '葫芦岛': [120.1575,40.578],
                      '衡水': [115.8838,37.7161],
                      '衢州': [118.6853,28.8666],
                      '西宁': [101.4038,36.8207],
                      '西安': [109.1162,34.2004],
                      '贵阳': [106.6992,26.7682],
                      '连云港': [119.1248,34.552],
                      '邢台': [114.8071,37.2821],
                      '邯郸': [114.4775,36.535],
                      '郑州': [113.4668,34.6234],
                      '鄂尔多斯': [108.9734,39.2487],
                      '重庆': [107.7539,30.1904],
                      '金华': [120.0037,29.1028],
                      '铜川': [109.0393,35.1947],
                      '银川': [106.3586,38.1775],
                      '镇江': [119.4763,31.9702],
                      '长春': [125.8154,44.2584],
                      '长沙': [113.0823,28.2568],
                      '长治': [112.8625,36.4746],
                      '阳泉': [113.4778,38.0951],
                      '青岛': [120.4651,36.3373],
                      '韶关': [113.7964,24.7028],
                                    "大理":[99.9536,25.6805],
                                    "丽江市":[99.448,23.955],
                                    "西双版纳":[100.8984,21.8628],
                    };

```



