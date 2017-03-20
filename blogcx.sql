-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: blogcx
-- ------------------------------------------------------
-- Server version	5.5.52-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group__permission_id_17b0d5bfc9449112_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permission_group_id_29cc51ff99ee2044_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group__permission_id_17b0d5bfc9449112_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth__content_type_id_53679fbb8565bc08_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add blog post',7,'add_blogpost'),(20,'Can change blog post',7,'change_blogpost'),(21,'Can delete blog post',7,'delete_blogpost'),(22,'Can add blog post image',8,'add_blogpostimage'),(23,'Can change blog post image',8,'change_blogpostimage'),(24,'Can delete blog post image',8,'delete_blogpostimage'),(25,'Can add Tag',9,'add_tag'),(26,'Can change Tag',9,'change_tag'),(27,'Can delete Tag',9,'delete_tag'),(28,'Can add Tagged Item',10,'add_taggeditem'),(29,'Can change Tagged Item',10,'change_taggeditem'),(30,'Can delete Tagged Item',10,'delete_taggeditem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$9GTXTqaxJjCh$Y8H5yU7vbKDFd5o6tN9yRZoYgW1WPklzoir8Ei37zRs=','2017-03-06 13:51:40',1,'maksim','','','ccxysfh1993@gmail.com',1,1,'2017-01-01 15:54:50');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_17877b78965ba020_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_17877b78965ba020_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_116aeae526d26c6c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_u_permission_id_2297235128a09b68_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_permissi_user_id_617608f14b3adc0a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_u_permission_id_2297235128a09b68_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `css3template_blog_blogpost`
--

DROP TABLE IF EXISTS `css3template_blog_blogpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `css3template_blog_blogpost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `md_file` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pub_date` datetime NOT NULL,
  `last_edit_date` datetime NOT NULL,
  `slug` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `html_file` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `css3template_blog_blogpost_2dbcba41` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `css3template_blog_blogpost`
--

LOCK TABLES `css3template_blog_blogpost` WRITE;
/*!40000 ALTER TABLE `css3template_blog_blogpost` DISABLE KEYS */;
INSERT INTO `css3template_blog_blogpost` VALUES (1,'写在2017元旦的2016总结 ','**2016始于焦躁，归于平静**。  \r\n  \r\n焦躁来源于对自己的不认同，对时间有着过大的压力，一方面想把事情做到完善，一方面又对时间充满恐惧，时间的压迫感时刻萦绕心头，这种感觉从年初到毕业，到研究生开学，直到11月的中旬。  \r\n  \r\n改变是从11月开始的，当回顾今年所历种种，发现最大的问题在于花了太多时间在为条件做准备，却忽略了最本源的问题，在焦虑中准备着条件，无时无刻不在时间的紧迫感之下，我开始转变思维，一切从问题出发，以此为基础逐步寻求问题的解决方案，这在2016年几乎一整年被自己忽视了。  \r\n  \r\n思维的转变是开始，也是关键，我开始积极的深入思考问题，为一个问题静坐十几个小时，积极参与课堂讨论，实验室交流，积极的去帮助别人解决问题，让自己成为一个能让别人感到安心的人——“就是有他在，事情一定能搞定的这种感觉”。  \r\n  \r\n##毕业  \r\n  \r\n2016是毕业季，因为很多人留在北京，所以并没有太多的离愁别绪，但有一件事始料未及，留下遗憾，不可挽回；抛开这个不谈，这是一个稍显波澜不惊的毕业季，最后的日子，大家好像很有默契的，一起做毕设，一起去跳蚤市场，一起去西瓜摊吃西瓜，一起穿学士服拍毕业照，也趁着德恩生日众人聚在一起，回忆往昔，展望未来。  \r\n  \r\n我是毕业典礼第二天晚上的火车票回家，离开宿舍的时候，莫名有些不舍，能够遇到几个志同道合的人作室友是很幸运的，不管是一直以来的小光、薛崇、康康和一强，还是后来加入的吴礼顺，我们中的几个在某些性情方面有着极大的共同点。  \r\n  \r\n聚散终有时，忘了是我还是小光是第一个走的，应该是我吧，妈妈千叮万嘱，急盼我早日回家。  \r\n  \r\n##旅行\r\n  \r\n张亦超同学对于这次旅行会有自己的解读，旅行分别那天是他的生日，我当时竟无心送上任何祝福，只是在他去机场的路上发了一条短信——“路上注意安全，一路顺风”，经此一别，至今再无联系，我很明确的表达我的态度，我会偶尔遗憾事情会发展成这样，但是绝不会有任何犹疑毋需再有过多交集的现状，乃至以后都是如此。  \r\n  \r\n在成都东站的时候，我经历了在2016年最无奈的时刻，最极致的无奈，虽然只有十几分钟，但真的已经足够令人失望了。  \r\n  \r\n感觉整件事情的发生在我的印象里太过深刻，我几乎能记起每个细节，但通常情况下，我对事情的印象是比较模糊的。事情缘起我帮助一位同下地铁的女生，她的火车临近发车，但似乎从出站开始就迷失了方向，并求助。由于并不确定路线一定正确，女生和我不自觉的都加快了步伐，考虑到张亦超同学当时手上还提着一个包，我不时回头看看他，以保证自己还在他的视野中，乘坐好几个扶梯终于上到地面，见到火车站，锁定售票处的时候，我才略微的放下心，又回头看了一眼张亦超同学，然后就带着女生径直去售票处了。但是解决完女生的事情后，回过神来，视野所及，已经没有了张亦超同学的身影，我当时并没有意识到发生了什么严重的事，赶紧拿出手机打电话，但电话居然无法接通，心里突然紧张起来，又连着打了几个，依旧无法接通，我第一反应是他的手机丢了，我一边不停的打他的电话，一边跑向火车站前广场保安亭，找到当值保安询问哪里能进行寻人广播，我多希望他也在找广播试图联系我啊，就算手机丢了，就算在这陌生之地，总能有方式联系上的吧。  \r\n  \r\n后来电话突然打通了，接通的一瞬间似乎还收到一条短信，电话那头平静如斯，淡淡的说自己已经提前先进站了，并发了一条短信给我，可电话这头的我心急如焚，却突然不知道要说什么，谁知道自己刚刚经历了什么，生气的同时，悬着的心终于又平复下来，多讽刺啊，挂了电话，我查看了短信，在那时短信的内容已经不重要了；进站了，我在车票的检票口附近寻觅他的身影，他静静地坐在座位上，手上拿着一本书，我感叹于人生的起起落落，刚刚那个以为突遇变故的人此刻正如此平静的坐在那，我也无法向他去述说刚刚发生的一切，因为他的态度写在他的短信里，表现在他决定在未确保我知悉的情况下提前进站的行为上。  \r\n  \r\n其实他本没有错的，只是未料到进站后没有信号或者信号很弱，短信没有及时发出来。我也不必过分苛责他，因为短信的内容表现了他的心意，如果我能及时看到短信，我能从对他的了解中理解他的行为，改变自己做的不对的地方，无心造成了某些误解，但是事情发生之后，我只会觉得短信的内容很幼稚。至于为什么当时没有直接放弃后面的行程买票回家，我也不知道，要是当时直接回来了就好了。   \r\n   \r\n他可以一直不知道事情的原委，他也可以一直从自己的视角来看待问题，但是作为一个成年人，有必要从更多的方面，更多的信息去解读事情发生的前因后果。我希望有一天能看到张亦超同学的视角中对事件的解读。  \r\n  \r\n我们赴2013夏未了之约，抵失厦门行之憾，却成最大遗憾；但这件事于我而言难以原谅。  \r\n  \r\n##爱情\r\n  \r\n焦躁的另一部分来源于所错失的爱情，依旧会从梦中不安的惊醒，怅然若失，11月中，我发现这种关系依旧是很模糊的，没有明确的断绝，却总有一些光，好像在说，不要放弃，你们还有可能，确实不应该拖延，想法应该明白说出来，如果不行，就及早言明态度，给双方各自足够的空间，如果可以，就一起努力为未来做准备。  \r\n  \r\n我在11月底向胡瑶表明心迹，忐忑不安了一整天，但回应的依旧是沉默；虽然没有回应，但坚定的表达了自己的想法后，也能坦然的接受这样的结果，内心也终于归于平静；12月12日胡瑶生日在微信上送上了生日祝福，也没有再邀请别人一起跨年，以前强行送人家礼物真的会很尴尬吧，原本跨年想一起去看周杰伦的音乐剧《不能说的秘密》，但最后去看了凤凰传奇的交响乐，真的好喜庆。  \r\n  \r\n在峨眉山，遇到暴雨，但是在山脚下，一对夫妻把车停在停车场，妻子要陪伴丈夫一起登山，很漂亮而且坚毅的妻子，我独自看着他们笑了，看着他们让人觉得甜蜜，很羡慕，两个人相互陪伴，共同去为生活增加色彩，就算身处异地，也会为相聚而千方百计，这才是爱情应该有的模样。  \r\n  \r\n##学习\r\n  \r\n自新学期开学以来，始终无法产生自我认同，大概是对处境的不满，不可否认的是现在的处境都是之前自己一系列的选择所决定的，那么此时再怀疑否定是于事无补的。  \r\n  \r\n既然任何事情都不可能做到准备好所有条件，那就尽量做现阶段所能做到的最好的，既然兀自强加给自己时间的压力并不能让事情得到更好的结果，那就不妨坚信自己的时间是无比充足的，既然会不时会感受到知识的浩渺自己有多么无知，那就不妨针对具体问题就某一领域深入研究。泛泛而谈只会徒增挫败感，而每一次小的成功和行动力则会不断积聚信心。\r\n  \r\n别人所看到的你，就是你当时自己内心自我的感觉，如果你坚毅自信，别人也会被你所感染，学习、工作、生活都是这样，所以不要恐惧学习、工作、生活，用爱去拥抱他们，想象你所能达到最好的状态，然后尽可能去接近这种状态，就像以前听说过的目标倒推法一样，如果你五年后想出一张专辑，你现在每个月就应该每天写10首歌，我们所做的每一步都是根据问题而来，一步步都在向解决问题靠近。  \r\n  \r\n学习的路上，人生的路上，不断让自己看到成果，不作苦行人，作自己的领路人。  \r\n  \r\n##方向  \r\n  \r\n不作游子，不作旅人，不作过客，努力留在北京，给所爱的人一个成全爱的环境，不管你是谁，一起努力吧，相信爱，付出爱，感恩爱，接受爱。  \r\n','content/BlogPost/2017/写在2017元旦的2016总结 .md','2017-01-01 15:55:18','2017-01-18 15:39:47','xie-zai-2017yuan-dan-de-2016zong-jie','content/BlogPost/2017/写在2017元旦的2016总结 .html','acg',''),(2,'春节假期充电','- 基础课程\r\n    - 算法\r\n    - 微积分\r\n    - 概率论\r\n- 形体学？礼仪课程\r\n- 数据挖掘\r\n- 英语语法及阅读\r\n- 阅读\r\n- 日常\r\n    - 练习开车\r\n    - 跑步\r\n\r\n  \r\n**随着学习的进程，会补充学习所要的素材，及自己的心得**\r\n  \r\n##礼仪课程\r\n  \r\n湖南大学袁涤非老师在网易公开课上的课程——<a href=\"http://open.163.com/movie/2011/10/L/T/M7GFJSVBV_M7HTM4VLT.html\" target=\"_blank\"> [ 湖南大学公开课：现代礼仪 ]</a>\r\n  \r\n中华华人讲师联盟的林美玉老师的一些演讲——<a href=\"https://www.youtube.com/watch?v=uwhOIU5T8Lc\" target=\"_blank\"> [ 禮儀課程 ] </a>\r\n  \r\n##阅读书单\r\n肯定是不能都读完的，加粗优先。  \r\n  \r\n1. 技术类\r\n    - Python网络数据采集\r\n    - CSS揭秘\r\n    - 微服务设计\r\n    - **GitHub入门与实践**\r\n    - 你不知道的JavaScript（中卷）\r\n    - 垃圾回收的算法与实现\r\n    - Java性能权威指南\r\n    - 数据科学入门\r\n2. 非技术类\r\n    - 写给大家看的设计书（第4版）\r\n    - 数学女孩\r\n    - 科学的极致：漫谈人工智能\r\n    - 数学女孩2：费马大定理\r\n    - 注意力：专注的科学与训练\r\n    - 进化：从孤胆极客到高效团队\r\n    - **番茄工作法图解：简单易行的时间管理方法**\r\n    - **普林斯顿微积分读本（修订版）**\r\n    - 黑客与画家：硅谷创业之父Paul Graham文集\r\n    - 社会工程：安全体系中的人性漏洞','content/BlogPost/2017/春节假期充电.md','2017-01-18 15:40:53','2017-01-24 06:17:57','chun-jie-jia-qi-chong-dian','content/BlogPost/2017/春节假期充电.html','programming',''),(3,'shares','英语魔法师之语法俱乐部初步整理要点，[pdf](/media/files/pdf/英语魔法师之语法俱乐部文档整理.pdf)版本，后期会制作成ppt并重新生成pdf版本。\r\n  \r\n听说最近大家还是缺敬业福，作为第一天就集齐五福的人，特地用ppt为大家制作了一张<a href=\"/media/files/images/fu-color.jpeg\"  target=\"_blank\">[敬业福无敌增强符]</a>,把前几天累计的好运气都给你，不过我也听说了多个手写福扫出敬业福的案例<a href=\"/media/files/images/fu-heibai.png\"  target=\"_blank\">[福]</a>','content/BlogPost/2017/shares.md','2017-01-18 16:08:17','2017-01-21 08:24:25','shares','content/BlogPost/2017/shares.html','nc',''),(4,'现代礼仪学习笔记','>中国大学视频公开课>湖南大学公开课：现代礼仪  \r\n  \r\n这里需要插入一个目录。  \r\n[toc] \r\n  \r\n---\r\n20170120    \r\n##礼仪概说\r\n成为有修养，有品位，有风度，有气质，懂得爱己爱人的现代人。 \r\n  \r\n**腹有诗书气自华**\r\n  \r\n###一、礼仪的定义和内涵 \r\n\r\n礼仪，是人们在社会交往活动中，为了相互尊重，在仪表、仪容、仪态、仪式、言谈举止等放方面约定俗成的，共同认可的行为规范。  \r\n内涵：礼貌、礼节、仪式（三个层次逐级上升、复杂、仪式化）。  \r\n\r\n###二、“礼”的起源和发展 \r\n\r\n甲骨文中的“礼”字为最初的起源，在祭祀中用。   \r\n“礼” 的形成阶段—古代思想家的论述。   \r\n人有礼则安，无礼则危。----《礼记》   \r\n衣食以厚民生，礼仪以养其心。-----许衡   \r\n克己复礼----孔子 《论语》   \r\n人无礼则不生，是无礼则不成，国家无礼则不宁。----荀子 《修身》   \r\n现代礼仪——变革发展阶段。 礼仪的内容日趋简单化，礼仪的标准日趋国际化 。  \r\n  \r\n###三、礼仪的实质和原则 \r\n\r\n实质：一个“敬”字， 敬己敬人 。孟子：“尊敬之心，礼也”。   \r\n原则：**尊重**、**自律**、**宽容**、**适度** 。  \r\n尊重领导是一种天职，尊重下属是一种美德，尊重别人是一种教养。   \r\n  \r\n###四、礼仪的特征和作用 \r\n\r\n特征：针对性、继承性、共同性、差异性、时代性 。   \r\n作用：自我完善的基础、组织形象的保证、文明程度的标志。    \r\n世界上最廉价而又能得到最大效益的一项物质，那就是礼节。    \r\n礼仪是现代社会做人做事必备的基本功，是个人素质能力的综合指数。在西方社会把礼仪视为人生成功的第一课。  \r\n\r\n##仪表仪态\r\n\r\n###一、 仪表礼仪\r\n  \r\n三分人才，七分打扮。  \r\n  \r\n**1.干净整洁**  \r\n发型：男士发式注意三不：前不附额、侧不掩耳、背不及领；女士留短发，长发扎起来（显得干练清爽） 。  \r\n面部：胡须刮干净，鼻毛不外现。  \r\n手部：手部尽量不要留长指甲，干净清洁 。  \r\n\r\n**2.化妆规范**\r\n女士：淡妆，自然、和谐、美化（要注意场合，最简单的就是眉毛+嘴唇）；男士注意头屑、胡子、鼻毛 。 \r\n  \r\n>一个人的穿着打扮就是他教养、品味、地位的最真实的写照。——莎士比亚\r\n  \r\n**3.服饰得体**\r\n\r\n- 符合身份\r\n- 区分场合\r\n- 遵守成规\r\n    - 制服：体现企业形象，规范化程度高，不可随意搭配。\r\n    - 西服：正式，面料与颜色统一，三色原则（身上所有颜色小于等于三色），三一定律（皮鞋、皮带、公文包颜色必须统一，正式的，准备黑色、咖啡色两套），三大禁忌（不拆商标，袜子颜色要棉袜，颜色深色，禁穿夹克打领带）\r\n    - 裙服：禁不穿袜子，袜子出问题要换，禁穿套装穿凉鞋，禁黑色短皮裙参与正式场合。\r\n- 巧用配饰\r\n    - 最多六个点，较一致\r\n    - 身上的颜色<=3种(除花色衣服)  \r\n    \r\n>着装的基本原则——TPO原则。T：Time 时间，P：Place 地点，O：Occasion场合。\r\n  \r\n根据自己的年龄、身份和职业选择服装，根据自己的形体条件选择服装。身材比较娇小（不要穿成一节一节的），偏胖要注意穿着简单，颜色简单。\r\n服饰重要性：鞋子>裤子>上衣打底>上衣外套。\r\n  \r\n###二、仪态礼仪\r\n\r\n>站如松，坐如钟，行如风\r\n  \r\n体语——最富魅力的语言，挺直如松的站姿， 文雅端庄的坐姿， 从容稳直的行姿，雅观得体的态姿。  \r\n\r\n男子要有阳刚之美，女子要优雅得体。\r\n\r\n站姿：男士双脚稍微分开一边肩宽；女士双脚完全并拢或者是很小的丁字步站着，不要太拘谨。左手放右手上面（左手比一般比右手美观）。  \r\n\r\n坐姿；最好从凳子的左侧开始入座，要根据凳子的大小适当的坐（小凳子坐三分之二，大凳子坐二分之一，不要靠到椅子背部）。\r\n\r\n捡东西的姿势：先整个身子弯下去，侧放腿，并用手捂住裙子，再去捡。\r\n\r\n不可以用一个手指去指人，不礼貌。而是用整个手掌介绍他人，指向他人等等。\r\n  \r\n男士不宜耸肩。\r\n\r\n##言谈礼仪\r\n\r\n**制衡世界的三大武器：演说、经济和原子弹。**言谈在社交生活中占据举足轻重轻重的地位。  \r\n\r\n语言两大类：无声语言与有声语言  \r\n言语表达——你的第二张名片：人的第一张明信片——人的仪表与仪态，或实物名片；第二张名片表现在**仪表仪态**、**口音**、**文化素养**及**思想内涵**。  \r\n  \r\n**思维路标**\r\n表达时要多理观点，归纳混乱都无所谓，但要展现条理逻辑性，**妙用数字，理清一个条理**：\r\n\r\n    一、二、三···；\r\n    一方面、一方面、另一方面；\r\n    首先、其次、再次、最后；\r\n    利的一面，不利的一面。\r\n  \r\n###一、言语交际的基本要求\r\n1. 态度谦虚诚恳，都用“请”、“请您”、“请教您”。\r\n2. 表情亲切自然（目视对方的眼睛，眼睛透出亲切自然，面带微笑）\r\n3. 语调平和沉稳\r\n4. 语言标准规范      \r\n  \r\n###二、谈话内容\r\n1. 六不宜\r\n    - 不要非议党和政府\r\n    - 不涉及国家秘密与行业秘密\r\n    - 不非议交往对象\r\n    - 不背后议论他人\r\n    - 不涉及格调不高的事情    \r\n    - 不涉及个人隐私\r\n2. 宜选的话题\r\n    - 格调高雅：体现个人品味。\r\n    - 轻松愉快：电视节目、电影及比赛等。\r\n    - 时尚流行：服饰、手机、歌曲及网络名词等。\r\n    - 对方擅长\r\n3. 谈话的艺术\r\n    - 音量适中，语言规范（与人交谈语量压低，语速适中，语言规范）\r\n    - 神情专注，少说多听（不打断，不补充，不纠正，不质疑对方）\r\n    - 嘘寒问暖，打开话匣子（问候式-表关心，言他式，触景生情式，赞美）\r\n    - 得体幽默，掌握分寸（妙用数字-思维路标-第一第二第三，巧打比方，趣用幽默，插入笑话）\r\n\r\n4. 巧用态势，加强互动  \r\n    言谈时用进表情、肢体语言。\r\n  \r\n##生活礼仪\r\n  \r\n###一、家庭礼仪\r\n\r\n>父子和而家不败，兄弟和而家不分，夫妇和而家道兴，乡党和而争讼息。\r\n  \r\n1. 成员礼仪\r\n    - 孝敬父母长辈\r\n    - 关爱兄弟姐妹（对现在的青年学子要提倡三知教育：第一，知书达理；第二，知恩图报；第三，知足常乐。）\r\n    - 礼待亲朋好友（敬老爱亲）\r\n    - 夫妻之间的礼仪：\r\n        - 互爱互谅\r\n        - 共同承担家务劳动\r\n        - 保持和修饰好自己的仪容\r\n  \r\n2. 称谓礼仪  \r\n    记住常规亲朋好友的称谓，这点自己就做的很不好，来人基本不清楚要怎么称呼。\r\n\r\n3. 仪式礼仪\r\n    - 结婚礼仪：\r\n        - 怀着愉悦的心情去；\r\n        - 突出新人，不抢锋芒；\r\n        - 吃饭时谦让，等人到齐，菜上齐；\r\n        - 不要特别早地中途离开，与新郎新娘道别才离开；\r\n        - 闹洞房适可而止。\r\n    - 丧事礼仪：\r\n        - 穿着深色的衣服；\r\n        - 说话的时候尽量低沉，做好少说话；\r\n        - 中途不要离开，从头到尾保持低沉的氛围。\r\n  \r\n4. 待客礼仪：来客出门打招呼，称有事再进来也无妨，但一定要出去。\r\n\r\n###二、学校礼仪\r\n1. 学生礼仪\r\n    - 仪表礼仪（不要穿拖鞋，低胸、吊带）\r\n    - 课堂礼仪（不要迟到，不要逃课，注重请假，下课帮老师擦黑板）\r\n    - 尊师礼仪（进门礼仪、请假礼仪、实习礼仪、节假礼仪）：**最大限度把老师掌握的东西挖掘出来变成自己的东西**\r\n    - 集会礼仪（早到，不非议，不早退）\r\n    - 同学间礼仪（善待同学，不要斤斤计较，借钱需还，懂得共享）\r\n    - 校内公共场合礼仪\r\n2. 教师礼仪\r\n    - 仪表礼仪（区分自己的身份、场合）\r\n    - 举止礼仪（言传身教，潜移默化）\r\n    - 言谈礼仪（维护学生，上课时言简意赅）\r\n  \r\n###三、出行礼仪\r\n- 行路礼仪（遵守交通规则，帮助老人、小孩）\r\n- 乘车礼仪（先下后上，主动让座，上车之后往后走，开车注重礼仪，礼让行人，下雨天的时候放慢车速，以免污水见到别人身上）\r\n- 乘飞机礼仪（提前一到两个小时到，按时登机;尤其是领取登机牌以后不要延误登机）\r\n- 乘电梯礼仪（不要并排站着，靠右站，自己与客人一起时，**先上先下**）\r\n\r\n###四、公共场合礼仪\r\n- 影院：准时到场，不要提前离开，不要吃食物，注意坐姿。\r\n- 超市\r\n- 旅游\r\n- 宾馆\r\n\r\n>礼仪没有大论，就是在自己的生活的每一方面为别人着想。\r\n\r\n**礼仪就是“敬”，敬人敬己**。\r\n\r\n---\r\n20170121\r\n\r\n##职场礼仪(一)\r\n###一、求职礼仪\r\n  \r\n1. 求职信\r\n    - 书写规范，包括措辞、格式、干净。最好是手写，是对别人的尊重，只要你的字不是太差。\r\n    - 谦恭有礼。您，谢谢\r\n    - 情真意切。表明你渴望这个职位，迫切心情，让爱这个岗位\r\n    - 言简意赅。最好不超过500字，最好一面纸。\r\n  \r\n2. 个人简历\r\n  \r\n3. 电话求职\r\n    - 择时（8：30之前不要给别人打电话，9至11之间最好，中午一定不要打电话，以免影响别人休息。2：45之后至5：00不要打家里的电话）\r\n    - 顺畅（把自己想在电话里面讲话先想好，最好先写下来，大体要讲什么，言简意赅）\r\n    - 致谢：表达谢意（谢谢您，非常感谢）\r\n  \r\n4. 面试  \r\n    -研究主考官\r\n    -研究自己\r\n知己知彼，百战不殆。例如：财务方面，要细心，有原则，熟悉法律法规。研究自身优势，了解这个公司的状况，找到自己与这个公司吻合的地方。\r\n\r\n###二、着装礼仪\r\n>你不可能仅仅由于带了一条领带而取得一个岗位，但是，我可以肯定你戴错了领带就失去一个职位。男生西装，不必是名牌，可以去租。女生套装。\r\n\r\n###三、见面礼仪\r\n- 遵时守信，提前十分钟，万一可能迟到，提前发短信，通知；\r\n- 关闭手机，耐心等待考试；\r\n- 敲门请示，轻进关门，最好三声；\r\n- 面带微笑，点头示意，用眼睛看每位评审，不知是站着还是坐着的时候，要询问，\r\n- 允后坐下，轻声言谢；\r\n- 所带资料，双手奉上。\r\n  \r\n经典面试题：  \r\n\r\n- 你来这里能够干什么？\r\n- 你为什么有兴趣来到这里？\r\n- 你自认为有什么优缺点？\r\n- 你善于与什么人相处？\r\n- 你为什么经常多次想调动工作？\r\n- 你认为你适合干什么?\r\n- 你对薪水的期望值是多少？\r\n- 你现在可以向我提问关于我们公司的任何问题。\r\n\r\n###四、面试结束后的礼仪\r\n1. 表示感谢:鞠躬，谢谢每一位主考官想你提供这次机会;\r\n2. 询问结果:不是当时，如果超过约定期限还没有收到答复，可以打电话向公司询问。\r\n  \r\n##职场礼仪(二)\r\n###一、工作礼仪\r\n\r\n人们在工作场所应当遵循的一系列礼仪规范。  \r\n  \r\n反躬自省：  \r\n\r\n- 你会打理自己的形象吗？\r\n- 你的举止得体吗?\r\n- 同事外出时，有人打电话找他，该如何应付？\r\n- 在电梯上遇到不认识的人，也必须打招呼吗？\r\n- 请客人到接待室时，自己应该先进去吗？\r\n- 写信给重要客户，写到最后一行才出错，可以用修正液改正吗？\r\n- 怎样得体的介绍别人？\r\n- 你懂得怎样向别人道歉吗？\r\n- 你知道怎样接听电话吗？\r\n  \r\n问答： \r\n\r\n- 请客人到接待室时，自己应该先进去吗？  \r\nA：根据门的朝向决定。例如门的朝向是向里面开的，敲三下门自己先进去，把门压着，用手引进客人。若门是朝外开的，自己拉开门，压着门，用手请进客人，客人先进。\r\n\r\n- 怎样得体的介绍别人？  \r\nA:很多人在场，应该按职位由高到低来一次介绍。若不明白高低，可以按照一定顺序介绍，事先向大家说明。\r\n    - 男士与女士见面，先把男士介绍给女士，女士有先知权；\r\n    - 长辈与晚辈见面，先把晚辈介绍给长辈；\r\n    - 领导和下属见面，要先把下属介绍给领导；\r\n    - 结婚的和没有结婚的先把没有结婚的介绍给结婚的。\r\n  \r\n1. 出入职场的必备礼仪\r\n    - 从小事中学习；\r\n    - 做一个执行职员（可以暂时搁置自己的顾虑，适时再提出来）；\r\n    - 脚踏实地的工作（认识事情都要务实，不要眼高手低，看着锅里的吃着碗里的）；\r\n    - 具有创新精神。\r\n2. 与上司说话的艺术\r\n    - 不要代替上司做决定，引导上司做出你的决定（有几种方法，充分说明有利有弊，自己阅历较浅，不知怎么做决定，让领导做决定）；\r\n    - 不要和上司开黑色玩笑（不要哪壶不开提哪壶）；\r\n    - 当无话可谈的时候，不妨谈论一下对方衣着的变化（无论面对谁，陌生的时候，可以从配饰、衣服，由衷的赞美）\r\n3. 与同事相处\r\n    - 尊重同事；\r\n    - 物质上的往来一定要清楚（借钱、接东西要还）；\r\n    - 对同事的困难要关心，全力帮助同事；\r\n    - 不在同事背后议论同事，以诚相待；\r\n    - 勇于认错道歉，勇于担当。\r\n    - 同事之间最不欢迎的类型：\r\n        - 唯我独尊型、奉承献媚型、自私自利型\r\n        - 自吹自擂型、自持老大型、不负责任型\r\n        - 明哲保身型、道人事非型、倨傲不恭型\r\n        - 浑水摸鱼型、吊儿郎当型 、浓妆艳抹型。\r\n \r\n4. 办公室礼仪禁忌\r\n    - 过分注重自己形象、滥用公共设施\r\n    - 零食香烟不离口（槟榔）、形象不得体\r\n    - 把办公室当家、高声喧哗\r\n    - 随便挪用别人的东西、偷听别人的说话\r\n    - 对同事的朋友冷漠、经常迟到。\r\n  \r\n##社交礼仪(一)\r\n###一、会面礼仪：\r\n- 微笑，是人类最富魅力的语言。会给人一种亲和力。\r\n- 称呼（职务【书记】，职称【李会计，高工】，泛称【女士，慎用小姐，先生，德高望重的女士有事称先生】） \r\n- 握手（位尊者优先【上级伸手，女士伸手】）\r\n- 会面名片（确定是自己的名片，正面朝对方，看着对方，两手接名片，看几眼，小声念内容，放入名片夹，准备两个名片夹，按照一定顺序排好）\r\n  \r\n###二、通讯礼仪  \r\n- 书信礼仪\r\n您有复指意，无“您们好”。  \r\n- 电话礼仪\r\n    - 拨打\r\n    - 接听\r\n    - 代接\r\n    - 使用手机\r\n    - 禁忌：\r\n        - 公话私用\r\n        - 高声接听\r\n        - 边走边用\r\n  \r\n###三、拜访礼仪  \r\n进门若都是陌生人，眼睛扫视众人，用复制称呼统一打招呼\r\n  \r\n###四、迎送礼仪  \r\n- 迎客：热情周到，宾至如归\r\n- 送客：真诚挽留，热情相送\r\n  \r\n##社交礼仪(二)\r\n###一、馈赠礼仪\r\n- 目的\r\n- 类型（公务，礼尚往来；个人【个人喜好】；精神【短信，鲜花，点歌】\r\n- 注意：\r\n    - 礼品轻重：交浅礼薄，谊深礼重\r\n    - 礼品选择：投其所好\r\n    - 送礼场合\r\n    - 礼品包装\r\n\r\n###二、宴请礼仪\r\n\r\n1. 形式与种类\r\n    - 宴会：国宴，正式宴会，便宴，家宴\r\n    - 冷餐宴（自助餐）\r\n    - 酒会\r\n    - 茶会\r\n    - 工作餐  \r\n2. 宴请原则\r\n5M原则：  \r\n    - Meeting 约会，约时间时给对方留有空间\r\n    - Media   环境\r\n    - Money   费用，带现金，避免不能网上支付的尴尬\r\n    - Menu    菜单，口味，忌口，民族\r\n    - Manner  举止，顺时针转动转盘\r\n3. 中餐礼仪\r\n4. 西餐礼仪\r\n\r\n\r\n###三、聚会\r\n- 守时\r\n- 着装\r\n- 定位（主次，确定主角）\r\n- 谈吐\r\n- 举止（文雅）\r\n\r\n','content/BlogPost/2017/现代礼仪学习笔记.md','2017-01-20 15:42:53','2017-01-22 01:06:16','xian-dai-li-yi-xue-xi-bi-ji','content/BlogPost/2017/现代礼仪学习笔记.html','nc',''),(5,'见字如面','有这样一个综艺，宛若清流，从历史的长河中选取信件，由今人演绎，既有豪朗壮阔的大江大河，也有儿女情长的缱绻情深，有昔人已逝的梦回长叹，也有黄口小儿的无知轻狂...\r\n  \r\n**许久未见的蒋勤勤真是美到令人心碎。**\r\n  \r\n<a href=\"https://v.qq.com/x/cover/1wk4hdedwpv0nth.html?start=0\"  target=\"_blank\">[见字如面]</a>','content/BlogPost/2017/见字如面.md','2017-01-24 15:49:40','2017-01-24 15:51:37','jian-zi-ru-mian','content/BlogPost/2017/见字如面.html','nc',''),(6,'记一件没有意义的事情','**打了一下午牌，要抓紧时间学习。**','content/BlogPost/2017/记一件没有意义的事情.md','2017-01-29 14:41:40','2017-01-29 14:41:40','ji-yi-jian-mei-you-yi-yi-de-shi-qing','content/BlogPost/2017/记一件没有意义的事情.html','nc','');
/*!40000 ALTER TABLE `css3template_blog_blogpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `css3template_blog_blogpostimage`
--

DROP TABLE IF EXISTS `css3template_blog_blogpostimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `css3template_blog_blogpostimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `blogpost_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cs_blogpost_id_30bed65e1cfb54ed_fk_css3template_blog_blogpost_id` (`blogpost_id`),
  CONSTRAINT `cs_blogpost_id_30bed65e1cfb54ed_fk_css3template_blog_blogpost_id` FOREIGN KEY (`blogpost_id`) REFERENCES `css3template_blog_blogpost` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `css3template_blog_blogpostimage`
--

LOCK TABLES `css3template_blog_blogpostimage` WRITE;
/*!40000 ALTER TABLE `css3template_blog_blogpostimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `css3template_blog_blogpostimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djang_content_type_id_4d10eecf6b624aee_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_780cd016fd802d1f_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_780cd016fd802d1f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_4d10eecf6b624aee_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-01-01 15:55:18','1','测试',1,'',7,1),(2,'2017-01-01 15:55:53','1','写在2017元旦的2016总结',2,'Changed title, body, category and tags.',7,1),(3,'2017-01-01 16:45:00','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(4,'2017-01-01 16:52:51','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(5,'2017-01-01 16:53:06','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(6,'2017-01-01 17:06:30','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(7,'2017-01-12 15:30:43','1','程昌新现在不在，晒太阳去了？',2,'Changed title, body and tags.',7,1),(8,'2017-01-12 15:31:49','1','程昌新现在不在，晒太阳去了？',2,'Changed body and tags.',7,1),(9,'2017-01-18 15:39:47','1','写在2017元旦的2016总结 ',2,'Changed title, body and tags.',7,1),(10,'2017-01-18 15:40:53','2','春节假期充电',1,'',7,1),(11,'2017-01-18 15:42:59','2','春节假期充电',2,'Changed body and tags.',7,1),(12,'2017-01-18 16:08:17','3','shares',1,'',7,1),(13,'2017-01-18 16:09:57','3','shares',2,'Changed body and tags.',7,1),(14,'2017-01-19 14:06:55','2','春节假期充电',2,'Changed body and tags.',7,1),(15,'2017-01-19 15:35:51','2','春节假期充电',2,'Changed body and tags.',7,1),(16,'2017-01-19 16:08:17','2','春节假期充电',2,'Changed body and tags.',7,1),(17,'2017-01-19 23:13:18','2','春节假期充电',2,'Changed body and tags.',7,1),(18,'2017-01-20 02:24:27','2','春节假期充电',2,'Changed body and tags.',7,1),(19,'2017-01-20 02:26:53','2','春节假期充电',2,'Changed body and tags.',7,1),(20,'2017-01-20 02:27:59','2','春节假期充电',2,'Changed body and tags.',7,1),(21,'2017-01-20 02:32:16','2','春节假期充电',2,'Changed tags.',7,1),(22,'2017-01-20 02:33:11','2','春节假期充电',2,'Changed body and tags.',7,1),(23,'2017-01-20 02:33:58','2','春节假期充电',2,'Changed body and tags.',7,1),(24,'2017-01-20 02:35:35','2','春节假期充电',2,'Changed body and tags.',7,1),(25,'2017-01-20 02:36:03','2','春节假期充电',2,'Changed body and tags.',7,1),(26,'2017-01-20 15:23:13','2','春节假期充电',2,'Changed body and tags.',7,1),(27,'2017-01-20 15:42:53','4','现代礼仪学习笔记',1,'',7,1),(28,'2017-01-20 15:44:31','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(29,'2017-01-20 15:55:51','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(30,'2017-01-20 15:57:07','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(31,'2017-01-20 15:57:34','4','现代礼仪学习笔记',2,'Changed tags.',7,1),(32,'2017-01-20 15:57:59','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(33,'2017-01-21 00:23:30','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(34,'2017-01-21 00:24:35','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(35,'2017-01-21 00:24:51','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(36,'2017-01-21 00:25:06','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(37,'2017-01-21 00:56:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(38,'2017-01-21 01:13:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(39,'2017-01-21 01:15:17','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(40,'2017-01-21 01:16:41','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(41,'2017-01-21 01:38:44','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(42,'2017-01-21 01:47:38','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(43,'2017-01-21 01:49:35','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(44,'2017-01-21 01:50:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(45,'2017-01-21 01:56:57','3','shares',2,'Changed body and tags.',7,1),(46,'2017-01-21 01:57:55','3','shares',2,'Changed body and tags.',7,1),(47,'2017-01-21 01:58:26','3','shares',2,'Changed body and tags.',7,1),(48,'2017-01-21 01:58:52','3','shares',2,'Changed body and tags.',7,1),(49,'2017-01-21 02:18:54','3','shares',2,'Changed body and tags.',7,1),(50,'2017-01-21 02:19:17','3','shares',2,'Changed body and tags.',7,1),(51,'2017-01-21 03:00:29','3','shares',2,'Changed body and tags.',7,1),(52,'2017-01-21 04:57:49','3','shares',2,'Changed body and tags.',7,1),(53,'2017-01-21 08:24:25','3','shares',2,'Changed body and tags.',7,1),(54,'2017-01-21 23:45:24','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(55,'2017-01-21 23:55:53','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(56,'2017-01-22 00:51:45','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(57,'2017-01-22 01:03:52','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(58,'2017-01-22 01:06:16','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(59,'2017-01-24 06:17:57','2','春节假期充电',2,'Changed body and tags.',7,1),(60,'2017-01-24 15:49:40','5','见字如面',1,'',7,1),(61,'2017-01-24 15:50:18','5','见字如面',2,'Changed body and tags.',7,1),(62,'2017-01-24 15:50:51','5','见字如面',2,'Changed body and tags.',7,1),(63,'2017-01-24 15:51:25','5','见字如面',2,'Changed body and tags.',7,1),(64,'2017-01-24 15:51:37','5','见字如面',2,'Changed tags.',7,1),(65,'2017-01-29 14:41:40','6','记一件没有意义的事情',1,'',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_2cfe8f1214b9802b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'css3template_blog','blogpost'),(8,'css3template_blog','blogpostimage'),(6,'sessions','session'),(9,'taggit','tag'),(10,'taggit','taggeditem');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-01-01 15:53:51'),(2,'auth','0001_initial','2017-01-01 15:53:51'),(3,'admin','0001_initial','2017-01-01 15:53:51'),(4,'contenttypes','0002_remove_content_type_name','2017-01-01 15:53:52'),(5,'auth','0002_alter_permission_name_max_length','2017-01-01 15:53:52'),(6,'auth','0003_alter_user_email_max_length','2017-01-01 15:53:52'),(7,'auth','0004_alter_user_username_opts','2017-01-01 15:53:52'),(8,'auth','0005_alter_user_last_login_null','2017-01-01 15:53:52'),(9,'auth','0006_require_contenttypes_0002','2017-01-01 15:53:52'),(10,'taggit','0001_initial','2017-01-01 15:53:52'),(11,'taggit','0002_auto_20150616_2121','2017-01-01 15:53:52'),(12,'css3template_blog','0001_initial','2017-01-01 15:53:52'),(13,'sessions','0001_initial','2017-01-01 15:53:52'),(14,'css3template_blog','0002_auto_20170101_2357','2017-01-01 15:57:45');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('d3z8ijnokvy5tsv4vkg66q5ybxg8086h','ZjFmOTdiNjRlMTU4ZjgxZDEyNWUxYzkwODkyYzkwOTMxMjQxYTQ1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiJiZTU3MTljYTIyMmJkMDZlZWRiZWU3MmYxMWNiZWVkZmY0M2U5NmY0In0=','2017-01-15 16:52:38'),('emxbzpxueqqk9e7lilegwhzmsknvqg3o','YmRmMzYzZjQwNjEzNDk2MjE0OGM3ZDY4OWM2NDBlOTAxNDMwNzZlNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-02-02 15:35:13'),('uf0tmy9bwnz3144x4e17clw9rwlsmnp9','YmRmMzYzZjQwNjEzNDk2MjE0OGM3ZDY4OWM2NDBlOTAxNDMwNzZlNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-03-20 13:51:40');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggit_tag`
--

DROP TABLE IF EXISTS `taggit_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggit_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_tag`
--

LOCK TABLES `taggit_tag` WRITE;
/*!40000 ALTER TABLE `taggit_tag` DISABLE KEYS */;
INSERT INTO `taggit_tag` VALUES (1,'python','python'),(2,'summary','summary'),(3,'grow-up','grow-up'),(4,'shares','shares'),(5,'etiquette','etiquette'),(6,'letter','letter'),(7,'study','study');
/*!40000 ALTER TABLE `taggit_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggit_taggeditem`
--

DROP TABLE IF EXISTS `taggit_taggeditem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggit_taggeditem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taggit_taggeditem_tag_id_6eec915446714267_fk_taggit_tag_id` (`tag_id`),
  KEY `taggit_taggeditem_af31437c` (`object_id`),
  KEY `taggit_taggeditem_content_type_id_7099af64d659f3d3_idx` (`content_type_id`,`object_id`),
  CONSTRAINT `taggit_taggeditem_tag_id_6eec915446714267_fk_taggit_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taggit_tag` (`id`),
  CONSTRAINT `taggi_content_type_id_5a629f5e9008b9e3_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_taggeditem`
--

LOCK TABLES `taggit_taggeditem` WRITE;
/*!40000 ALTER TABLE `taggit_taggeditem` DISABLE KEYS */;
INSERT INTO `taggit_taggeditem` VALUES (2,1,7,2),(3,2,7,3),(4,3,7,4),(5,4,7,5),(6,5,7,6),(7,6,7,7);
/*!40000 ALTER TABLE `taggit_taggeditem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-20 21:20:30
