-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: blogcx
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB

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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$9GTXTqaxJjCh$Y8H5yU7vbKDFd5o6tN9yRZoYgW1WPklzoir8Ei37zRs=','2017-04-30 00:18:49',1,'maksim','','','ccxysfh1993@gmail.com',1,1,'2017-01-01 15:54:50');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `css3template_blog_blogpost`
--

LOCK TABLES `css3template_blog_blogpost` WRITE;
/*!40000 ALTER TABLE `css3template_blog_blogpost` DISABLE KEYS */;
INSERT INTO `css3template_blog_blogpost` VALUES (1,'写在2017元旦的2016总结 ','**2016始于焦躁，归于平静**。  \r\n  \r\n焦躁来源于对自己的不认同，对时间有着过大的压力，一方面想把事情做到完善，一方面又对时间充满恐惧，时间的压迫感时刻萦绕心头，这种感觉从年初到毕业，到研究生开学，直到11月的中旬。  \r\n  \r\n改变是从11月开始的，当回顾今年所历种种，发现最大的问题在于花了太多时间在为条件做准备，却忽略了最本源的问题，在焦虑中准备着条件，无时无刻不在时间的紧迫感之下，我开始转变思维，一切从问题出发，以此为基础逐步寻求问题的解决方案，这在2016年几乎一整年被自己忽视了。  \r\n  \r\n思维的转变是开始，也是关键，我开始积极的深入思考问题，为一个问题静坐十几个小时，积极参与课堂讨论，实验室交流，积极的去帮助别人解决问题，让自己成为一个能让别人感到安心的人——“就是有他在，事情一定能搞定的这种感觉”。  \r\n  \r\n##毕业  \r\n  \r\n2016是毕业季，因为很多人留在北京，所以并没有太多的离愁别绪，但有一件事始料未及，留下遗憾，不可挽回；抛开这个不谈，这是一个稍显波澜不惊的毕业季，最后的日子，大家好像很有默契的，一起做毕设，一起去跳蚤市场，一起去西瓜摊吃西瓜，一起穿学士服拍毕业照，也趁着德恩生日众人聚在一起，回忆往昔，展望未来。  \r\n  \r\n我是毕业典礼第二天晚上的火车票回家，离开宿舍的时候，莫名有些不舍，能够遇到几个志同道合的人作室友是很幸运的，不管是一直以来的小光、薛崇、康康和一强，还是后来加入的吴礼顺，我们中的几个在某些性情方面有着极大的共同点。  \r\n  \r\n聚散终有时，忘了是我还是小光是第一个走的，应该是我吧，妈妈千叮万嘱，急盼我早日回家。  \r\n  \r\n##旅行\r\n  \r\n张亦超同学对于这次旅行会有自己的解读，旅行分别那天是他的生日，我当时竟无心送上任何祝福，只是在他去机场的路上发了一条短信——“路上注意安全，一路顺风”，经此一别，至今再无联系，我很明确的表达我的态度，我会偶尔遗憾事情会发展成这样，但是绝不会有任何犹疑毋需再有过多交集的现状，乃至以后都是如此。  \r\n  \r\n在成都东站的时候，我经历了在2016年最无奈的时刻，最极致的无奈，虽然只有十几分钟，但真的已经足够令人失望了。  \r\n  \r\n感觉整件事情的发生在我的印象里太过深刻，我几乎能记起每个细节，但通常情况下，我对事情的印象是比较模糊的。事情缘起我帮助一位同下地铁的女生，她的火车临近发车，但似乎从出站开始就迷失了方向，并求助。由于并不确定路线一定正确，女生和我不自觉的都加快了步伐，考虑到张亦超同学当时手上还提着一个包，我不时回头看看他，以保证自己还在他的视野中，乘坐好几个扶梯终于上到地面，见到火车站，锁定售票处的时候，我才略微的放下心，又回头看了一眼张亦超同学，然后就带着女生径直去售票处了。但是解决完女生的事情后，回过神来，视野所及，已经没有了张亦超同学的身影，我当时并没有意识到发生了什么严重的事，赶紧拿出手机打电话，但电话居然无法接通，心里突然紧张起来，又连着打了几个，依旧无法接通，我第一反应是他的手机丢了，我一边不停的打他的电话，一边跑向火车站前广场保安亭，找到当值保安询问哪里能进行寻人广播，我多希望他也在找广播试图联系我啊，就算手机丢了，就算在这陌生之地，总能有方式联系上的吧。  \r\n  \r\n后来电话突然打通了，接通的一瞬间似乎还收到一条短信，电话那头平静如斯，淡淡的说自己已经提前先进站了，并发了一条短信给我，可电话这头的我心急如焚，却突然不知道要说什么，谁知道自己刚刚经历了什么，生气的同时，悬着的心终于又平复下来，多讽刺啊，挂了电话，我查看了短信，在那时短信的内容已经不重要了；进站了，我在车票的检票口附近寻觅他的身影，他静静地坐在座位上，手上拿着一本书，我感叹于人生的起起落落，刚刚那个以为突遇变故的人此刻正如此平静的坐在那，我也无法向他去述说刚刚发生的一切，因为他的态度写在他的短信里，表现在他决定在未确保我知悉的情况下提前进站的行为上。  \r\n  \r\n其实他本没有错的，只是未料到进站后没有信号或者信号很弱，短信没有及时发出来。我也不必过分苛责他，因为短信的内容表现了他的心意，如果我能及时看到短信，我能从对他的了解中理解他的行为，改变自己做的不对的地方，无心造成了某些误解，但是事情发生之后，我只会觉得短信的内容很幼稚。至于为什么当时没有直接放弃后面的行程买票回家，我也不知道，要是当时直接回来了就好了。   \r\n   \r\n他可以一直不知道事情的原委，他也可以一直从自己的视角来看待问题，但是作为一个成年人，有必要从更多的方面，更多的信息去解读事情发生的前因后果。我希望有一天能看到张亦超同学的视角中对事件的解读。  \r\n  \r\n我们赴2013夏未了之约，抵失厦门行之憾，却成最大遗憾；但这件事于我而言难以原谅。  \r\n  \r\n##爱情\r\n  \r\n焦躁的另一部分来源于所错失的爱情，依旧会从梦中不安的惊醒，怅然若失，11月中，我发现这种关系依旧是很模糊的，没有明确的断绝，却总有一些光，好像在说，不要放弃，你们还有可能，确实不应该拖延，想法应该明白说出来，如果不行，就及早言明态度，给双方各自足够的空间，如果可以，就一起努力为未来做准备。  \r\n  \r\n我在11月底向胡瑶表明心迹，忐忑不安了一整天，但回应的依旧是沉默；虽然没有回应，但坚定的表达了自己的想法后，也能坦然的接受这样的结果，内心也终于归于平静；12月12日胡瑶生日在微信上送上了生日祝福，也没有再邀请别人一起跨年，以前强行送人家礼物真的会很尴尬吧，原本跨年想一起去看周杰伦的音乐剧《不能说的秘密》，但最后去看了凤凰传奇的交响乐，真的好喜庆。  \r\n  \r\n在峨眉山，遇到暴雨，但是在山脚下，一对夫妻把车停在停车场，妻子要陪伴丈夫一起登山，很漂亮而且坚毅的妻子，我独自看着他们笑了，看着他们让人觉得甜蜜，很羡慕，两个人相互陪伴，共同去为生活增加色彩，就算身处异地，也会为相聚而千方百计，这才是爱情应该有的模样。  \r\n  \r\n##学习\r\n  \r\n自新学期开学以来，始终无法产生自我认同，大概是对处境的不满，不可否认的是现在的处境都是之前自己一系列的选择所决定的，那么此时再怀疑否定是于事无补的。  \r\n  \r\n既然任何事情都不可能做到准备好所有条件，那就尽量做现阶段所能做到的最好的，既然兀自强加给自己时间的压力并不能让事情得到更好的结果，那就不妨坚信自己的时间是无比充足的，既然会不时会感受到知识的浩渺自己有多么无知，那就不妨针对具体问题就某一领域深入研究。泛泛而谈只会徒增挫败感，而每一次小的成功和行动力则会不断积聚信心。\r\n  \r\n别人所看到的你，就是你当时自己内心自我的感觉，如果你坚毅自信，别人也会被你所感染，学习、工作、生活都是这样，所以不要恐惧学习、工作、生活，用爱去拥抱他们，想象你所能达到最好的状态，然后尽可能去接近这种状态，就像以前听说过的目标倒推法一样，如果你五年后想出一张专辑，你现在每个月就应该每天写10首歌，我们所做的每一步都是根据问题而来，一步步都在向解决问题靠近。  \r\n  \r\n学习的路上，人生的路上，不断让自己看到成果，不作苦行人，作自己的领路人。  \r\n  \r\n##方向  \r\n  \r\n不作游子，不作旅人，不作过客，努力留在北京，给所爱的人一个成全爱的环境，不管你是谁，一起努力吧，相信爱，付出爱，感恩爱，接受爱。  \r\n','content/BlogPost/2017/写在2017元旦的2016总结 .md','2017-01-01 15:55:18','2017-01-18 15:39:47','xie-zai-2017yuan-dan-de-2016zong-jie','content/BlogPost/2017/写在2017元旦的2016总结 .html','acg',''),(2,'春节假期充电','- 基础课程\r\n    - 算法\r\n    - 微积分\r\n    - 概率论\r\n- 形体学？礼仪课程\r\n- 数据挖掘\r\n- 英语语法及阅读\r\n- 阅读\r\n- 日常\r\n    - 练习开车\r\n    - 跑步\r\n\r\n  \r\n**随着学习的进程，会补充学习所要的素材，及自己的心得**\r\n  \r\n##礼仪课程\r\n  \r\n湖南大学袁涤非老师在网易公开课上的课程——<a href=\"http://open.163.com/movie/2011/10/L/T/M7GFJSVBV_M7HTM4VLT.html\" target=\"_blank\"> [ 湖南大学公开课：现代礼仪 ]</a>\r\n  \r\n中华华人讲师联盟的林美玉老师的一些演讲——<a href=\"https://www.youtube.com/watch?v=uwhOIU5T8Lc\" target=\"_blank\"> [ 禮儀課程 ] </a>\r\n  \r\n##阅读书单\r\n肯定是不能都读完的，加粗优先。  \r\n  \r\n1. 技术类\r\n    - Python网络数据采集\r\n    - CSS揭秘\r\n    - 微服务设计\r\n    - **GitHub入门与实践**\r\n    - 你不知道的JavaScript（中卷）\r\n    - 垃圾回收的算法与实现\r\n    - Java性能权威指南\r\n    - 数据科学入门\r\n2. 非技术类\r\n    - 写给大家看的设计书（第4版）\r\n    - 数学女孩\r\n    - 科学的极致：漫谈人工智能\r\n    - 数学女孩2：费马大定理\r\n    - 注意力：专注的科学与训练\r\n    - 进化：从孤胆极客到高效团队\r\n    - **番茄工作法图解：简单易行的时间管理方法**\r\n    - **普林斯顿微积分读本（修订版）**\r\n    - 黑客与画家：硅谷创业之父Paul Graham文集\r\n    - 社会工程：安全体系中的人性漏洞','content/BlogPost/2017/春节假期充电.md','2017-01-18 15:40:53','2017-01-24 06:17:57','chun-jie-jia-qi-chong-dian','content/BlogPost/2017/春节假期充电.html','programming',''),(3,'shares','英语魔法师之语法俱乐部初步整理要点，[pdf](/media/files/pdf/英语魔法师之语法俱乐部文档整理.pdf)版本，后期会制作成ppt并重新生成pdf版本。\r\n  \r\n仅留此<a href=\"/media/files/images/fu-color.jpeg\"  target=\"_blank\">[敬业福无敌增强符]</a>,是为2017春节所作。','content/BlogPost/2017/shares.md','2017-01-18 16:08:17','2017-03-31 08:33:36','shares','content/BlogPost/2017/shares_DmPoWcg.html','nc',''),(5,'见字如面','有这样一个综艺，宛若清流，从历史的长河中选取信件，由今人演绎，既有豪朗壮阔的大江大河，也有儿女情长的缱绻情深，有昔人已逝的梦回长叹，也有黄口小儿的无知轻狂...\r\n  \r\n**许久未见的蒋勤勤真是美到令人心碎。**\r\n  \r\n<a href=\"https://v.qq.com/x/cover/1wk4hdedwpv0nth.html?start=0\"  target=\"_blank\">[见字如面]</a>','content/BlogPost/2017/见字如面.md','2017-01-24 15:49:40','2017-01-24 15:51:37','jian-zi-ru-mian','content/BlogPost/2017/见字如面.html','nc',''),(7,'源码计划','在近半年对python的使用过程中，python作为一种工具，极大的提高了我的工作效率，它的语法如此优雅随性，它的功能如此多样，几近无所不能。我已经决定将python作为我的主要语言，也自此颠覆了java作为引我进入编程世界的入门程序，在我心中长期以来的主语言地位。java是我积累信心的基石，如今也算是完成历史使命，带着我曾经注入它的钻研和热爱，自此成为历史。  \r\n\r\n  \r\n\r\n在将python作为工具一段时间后，虽然总能顺利的解决问题，但之后真正的感觉是凌乱不成体系，对语言内核的理解也浮于表面，最好的学习方式是阅读,因而我决定再次像一个入门者一样，以编程新手的身份去重新认识python，从阅读源码，阅读别人所写的优秀代码开始，跳出这个安逸太久的区域。\r\n\r\n  \r\n\r\n源码阅读的第一部分从twisted开始，这是一个异步网络编程框架，阅读twisted源码，同时深入python源文件，**here we go**.\r\n\r\n  \r\n\r\n> 这是我的<a href=\"https://github.com/ccxysfh/ReadSourcePlan\" target=\"_blank\">笔记仓库</a>，我会直接将对源码的理解疑问标注在源文件里。','content/BlogPost/2017/源码计划.md','2017-03-23 14:50:44','2017-03-31 09:04:16','yuan-ma-ji-hua','content/BlogPost/2017/源码计划.html','programming',''),(8,'python中的延迟','> python版本3.5.2\r\n\r\npython提供了工具在需要时才产生结果，即一次产生一个结果项，而不是在内存中一次产生全部结果列表。\r\n\r\n延迟的核心是迭代器。\r\n\r\n后面的内容包括以下几个部分，可迭代对象和迭代器，生成器，map和zip，filter和reduce，序列range，enumerate，文件迭代器，字典视图迭代器。\r\n\r\n## 可迭代对象和迭代器\r\n\r\n一个可迭代对象需要支持`__iter__()`和`__next__()`这两个方法，这两个方法构成迭代协议。\r\n\r\n`__iter__()`返回迭代器对象本身,它允许对象（容器containers和迭代器iterators）在for和in表达式中直接使用；\r\n\r\n`__next__()`返回容器container中的下一个元素，如果没有更多元素，则会引起`StopIteration`异常。\r\n\r\n生成器是实现迭代协议的一种便利方式，如果一个容器对象的`__iter__()`是以生成器实现的，它会自动返回一个生成器对象。\r\n\r\n> 在之后的阅读中始终注意，哪些对象本身就是迭代器，哪些对象需要使用iter(self)来返回迭代器。\r\n\r\n## 生成器\r\n\r\n**一个生成器的迭代器是生成器自身**。\r\n\r\n**一个生成器运行到完成，必须产生一个新的生成器以再次开始**。\r\n\r\n有两种语言结构尽可能的延迟结果创建，无需一次构建所有对象：生成器函数和生成器表达式。\r\n\r\n1. 生成器函数\r\n\r\n   举例说明，有如下定义：\r\n\r\n   ```python\r\n   def gen():\r\n       for i in range(5):\r\n           x = yield i\r\n           print(\"x:\",x)\r\n   ```\r\n\r\n   理解`yield`：\r\n\r\n   yield表达式只在定义生成器函数时使用，而且也只能在函数体中使用。使用了yield表达式的函数会被特别的解释为生成器。yield语句挂起该函数并向调用者发送回一个值，同时保留足够的状态使得函数从离开的地方继续。\r\n\r\n   当通过调用生成器的某个方法继续时，函数在yield返回后立即继续执行，继续时yield表达式的值取决于调用的方法，如果调用的是`__next__()`即内置函数`next()`,yield表达式的值为`None`,如果是`send()`，则yield表达式的值为传递给send方法的值。\r\n\r\n   理解`yield from`：\r\n\r\n   将后面的表达式视为子迭代器，子迭代器的所有返回值都会直接返回给当前生成器的调用者；同理，外部调用`send()`和`throw()`也可直接传递到子迭代器(也是生成器的话)内部。下面的两条语句作用是一致的：\r\n\r\n   ```python\r\n   yield from iterable\r\n   for item in iterable: yield item\r\n   ```\r\n\r\n   当一个生成器函数被调用时，返回一个生成器作为迭代器，在一个list内置调用中包含一个生成器表达式以迫使其生成包含所有结果的列表：\r\n\r\n   ```python\r\n   >>>g = gen()\r\n   >>>list(g)\r\n   [0, 1, 2, 3, 4]\r\n   ```\r\n\r\n   也可以通过next方法依次获取,直到StopIteration异常，生成器运行完成：\r\n\r\n   ```python\r\n   >>>g = gen()\r\n   >>>next(g)\r\n   0\r\n   >>>next(g)\r\n   x: None\r\n   1\r\n   ···\r\n   >>>next(g)\r\n   StopIteration\r\n   ```\r\n\r\n   生成器函数协议中增加了一个send方法，send方法的行为可以这么理解:\r\n\r\n   1. 将值发送给生成器，即回到生成器函数内部的，yield表达式返回发送的值：\r\n\r\n      ```python\r\n      >>>g = gen()\r\n      >>>next(g)\r\n      0\r\n      >>>g.send(100)\r\n      x: 100\r\n      1\r\n      ```\r\n\r\n   2. 如果没有调用send，正常调用next，那么在生成器函数内部yield表达式返回None：\r\n\r\n      ```Python\r\n      >>>g = gen()\r\n      >>>next(g)\r\n      0\r\n      >>>next(g)\r\n      x: None\r\n      1\r\n      ```\r\n\r\n   通过一个实例更好的理解`yield from`和生成器的`send`方法，定义如下两个生成器：\r\n\r\n   ```Python\r\n   def accumulate():\r\n       tally = 0\r\n       while 1:\r\n           next = yield\r\n           if next is None:\r\n               return tally\r\n           tally += next\r\n\r\n   def gather_tallies(tallies):\r\n       while 1:\r\n           tally = yield from accumulate()\r\n           tallies.append(tally)\r\n   ```\r\n\r\n   按如下方式进行调用：\r\n\r\n   ```python\r\n   tallies = []\r\n   acc = gather_tallies(tallies)\r\n   next(acc)  # Ensure the accumulator is ready to accept values\r\n\r\n   for i in range(4):\r\n       acc.send(i)\r\n   acc.send(None)  # Finish the first tally\r\n\r\n   for i in range(5):\r\n       acc.send(i)\r\n   acc.send(None)  # Finish the second tally\r\n\r\n   >>>tallies\r\n   [6, 10]\r\n   ```\r\n\r\n2. 生成器表达式\r\n\r\n   迭代器和列表解析的概念形成生成器表达式，与列表解析不同，生成器表达式包含在园括号(parentheses)而不是方括号(brackets or curly braces)中，如(x ** 2 for x in range(4))。\r\n\r\n## map和zip\r\n\r\n### map\r\n\r\n用法：`map(function, iterable, ...)`，对iterable的每个元素应用function，并将结果以生成器返回；如果参数中有多个可迭代对象，function必须能接收多个参数，当最短的可迭代对象耗尽时，迭代停止。\r\n\r\n```python\r\n>>>m = map(abs,[-1, 0, 1])\r\n>>>iter(m) is m\r\nTrue\r\n```\r\n\r\n自定义一个map函数：\r\n\r\n```python\r\ndef mymap(func,*seqs):\r\n    res = []\r\n    for args in zip(*seqs):\r\n        res.append(func(*args))\r\n    return res\r\n```\r\n\r\n```Python\r\n# 或者是更简洁的列表解析式的表达,\r\ndef mymap(func,*seqs):\r\n    return [func(*args) for args in zip(*seqs)]\r\n>>>mymap(abs, [-2, -1, 0, 1, 2])\r\n[2, 1, 0, 1, 2]\r\n>>>mymap(pow, [1 ,2 ,3], [2, 3, 4, 5])\r\n[1, 8, 81]\r\n```\r\n\r\n```Python\r\n# 上面的实现和实际的map略有差异，更优的方案是通过生成器函数和生成器表达式来返回结果\r\ndef mymap(func,*seqs):\r\n    for args in zip(*seqs):\r\n        yield func(*args)\r\n# 生成器表达式\r\ndef mymap(func,*seqs):\r\n    return (func(*args) for args in zip(*seqs))\r\n>>>mymap(abs, [-2, -1, 0, 1, 2])\r\n<generator object mymap.<locals>.<genexpr> at 0x102583bf8>\r\n```\r\n\r\n### zip\r\n\r\n用法：`zip(*iterables)`从每个可迭代对象iterable中取出一个元素组成元组，以迭代器的形式返回这些元组，当最短的那个可迭代对象耗尽时，迭代停止。\r\n\r\n```python\r\n>>>z = zip([\'a\', \'b\', \'c\'],[1, 2, 3])\r\n>>>iter(z) is z\r\nTrue\r\n```\r\n\r\n`zip`用来迭代多个序列，`zip(a,b)`会生成一个可返回元组`(x,y)`的**迭代器**，其中x来自a，y来自b；一旦其中某个序列遍历完，迭代结束，因此迭代长度和参数中最短序列长度一致；`zip`会创建一个迭代器来作为结果返回，如果需要将所有结果存储在列表中，要使用`list()`方法。\r\n\r\n\r\n\r\n自定义zip前先了解两个内置函数all和any（之后也许会有一个关于内置函数的专题），`all(iterable)`,如果可迭代的对象(数组，字符串，列表等)中的元素都不为空的话返回 `True`；`any(iterable)`，如果可迭代的对象中任何一个元素不为空的话返回 `True` ，如果可迭代的对象都为空则返回 `False` ，自定义一个zip函数：\r\n\r\n```Python\r\ndef myzip(*seqs):\r\n    seqs = [list(S) for S in seqs]\r\n    res = []\r\n    while all(seqs):\r\n        res.append(tuple(S.pop(0) for S in seqs))\r\n        # 类似木桶原理，当最短的那个可迭代的对象遍历完成后，all(seqs)返回False\r\n    return res\r\n```\r\n\r\n```python\r\n# 使用生成器函数表达\r\ndef myzip(*seqs):\r\n    seqs = [list(S) for S in seqs]\r\n    while all(seqs):\r\n        yield tuple(S.pop(0) for S in seqs)\r\n```\r\n\r\n```python\r\n# 结合map实现zip\r\ndef myzip(*args):\r\n    iters = list(map(iter, args))\r\n    while iters:\r\n        res = [next(i) for i in iters]\r\n        yield tuple(res)\r\n    \"\"\"\r\n    如果把iters = list(map(iter, args))替换为iters = map(iter, args)\r\n    在python3中，myzip会陷入无限循环，map返回一个单次可迭代对象，只要在循环中运行一次列表解析，iters不为空（是\'<map object at 0x107c242e8>\'），但iters的迭代结果将会永远为空，并且res是[],需要使用list来创建一个支持多次迭代的对象。\r\n    \"\"\"\r\n```\r\n\r\n## filter和reduce\r\n\r\n### filter\r\n\r\n用法：`filter(function, iterable)`，从可迭代对象iterable中取出function返回`True`的元素构造的迭代器，等价表达：\r\n\r\n```python\r\n# if function is not None\r\n(item for item in iterable if function(item))\r\n# if function is None\r\n(item for item in iterable if item)\r\n```\r\n\r\n```python\r\n>>>filt = filter(lambda x: x > 0, [-1, 0, 1])\r\n>>>iter(filt) is filt\r\nTrue\r\n```\r\n\r\n### reduce\r\n\r\n用法：`functools.reduce(function, iterable[, initializer])`,对可迭代对象iterable累积应用于有两个参数的function，直到将可迭代对象iterable归约为一个值，比如`reduce(lambda x, y: x+y, [1, 2, 3,4, 5])` 等效于`((((1+2)+3)+4)+5)`，`reduce`实现：\r\n\r\n```python\r\ndef reduce(function, iterable, initializer=None):\r\n    it = iter(iterable)\r\n    if initializer is None:\r\n        value = next(it)\r\n    else:\r\n        value = initializer\r\n    for element in it:\r\n        value = function(value, element)\r\n    return value\r\n```\r\n\r\n## 序列range\r\n\r\n用法：`range(stop)`和`range(start, stop[, step])`\r\n\r\n支持多个活跃迭代器。\r\n\r\n```python\r\n>>>r = range(5)\r\n>>>r\r\nrange(0, 5)\r\n>>>iter(r)\r\n<range_iterator at 0x107c46fc0>\r\n>>>iter(r) is r\r\nFalse\r\n```\r\n\r\nrange是一个可迭代对象，根据需要产生元素\r\n\r\n## enumerate\r\n\r\n迭代一个序列的同时跟踪正在被处理元素的索引。\r\n\r\n用法：`enumerate(iterable, start=0）`,\r\n\r\n```python\r\n>>>D = dict(a=1, b=2, c=3)\r\n>>>eD = enumerate(D)\r\n>>>iter(eD) is eD\r\nTrue\r\n```\r\n\r\n`enumerate`的等价表达：\r\n\r\n```python\r\ndef enumerate(sequence, start=0):\r\n    n = start\r\n    for elem in sequence:\r\n        yield n, elem\r\n        n += 1\r\n```\r\n\r\n## 文件\r\n\r\n文件对象的迭代器是文件本身\r\n\r\n```python\r\n>>>f = open(\'hello.py\')\r\n>>>iter(f) is f\r\nTrue\r\n```\r\n\r\n文件读取可以使用`readlines`直接将文件全部加载到内存中，但往往这种方法的效果很差，甚至会出现内存不够的情况，下面这种逐行读取的迭代器版本效果会更好：\r\n\r\n```python\r\nfor line in open(\'hello.py\'):\r\n    print(line, end=\'\')\r\n```\r\n\r\n## 字典视图迭代器\r\n\r\n`keys()`,`values()`,`items()`,分别返回字典相应的视图，即返回的是字典实体的动态视图，如果字典变化了,视图相应变化，迭代视图时如果修改了实体会引发`RuntimeError`。\r\n\r\n```python\r\n>>>D = dict(a=1, b=2, c=3)\r\n>>>D.keys()\r\ndict_keys([\'b\', \'a\', \'c\'])\r\n>>>D.values()\r\ndict_values([2, 1, 3])\r\n>>>D.items()\r\ndict_items([(\'b\', 2), (\'a\', 1), (\'c\', 3)])\r\n```\r\n\r\n```Python\r\n>>>D = dict(a=1, b=2, c=3)\r\n>>>iter(D) is D # 字典有自己的迭代器，返回连续的键,可以直接迭代\r\nFalse\r\n>>>for key in D:print(key, end=\' \')\r\nb a c\r\n```','content/BlogPost/2017/python中的延迟_NMoq6GY.md','2017-04-27 16:54:00','2017-04-29 11:56:49','pythonzhong-de-yan-chi','content/BlogPost/2017/python中的延迟_JquV9Yc.html','programming',''),(9,'网络检索优化','设法在搜索结果中脱颖而出：\r\n\r\n1. Google 会参考所提供的网页标题，作为在搜索结果中显示的标题。\r\n2. 域名是Google 搜索结果中的重要部分。选择一个描述性域名。\r\n3. Google 和其他搜索引擎经常会在搜索结果页上使用元说明作为网页摘要。请为每个网页写一份独一无二且不超过160 个字符的描述\r\n\r\n## 创建独特准确的页面标题\r\n\r\n> 页面标题是搜索引擎优化的一个重要方面。\r\n\r\n1. 准确描述网页内容\r\n2. 为每个网页创建独特的标题标签\r\n3. 使用剪短的，但具描述性的标题标签\r\n\r\n优化：不再保留主页统一标题，以每篇文章的标题作为网页标题。\r\n\r\n## 更好的使用描述元标签\r\n\r\n1. 为每一页的内容进行总结\r\n\r\n2. 描述性元标签的主要作用\r\n\r\n   google可能会使用描述元标签来生成网页的摘要。\r\n\r\n优化：将每篇文章的tag标签放入描述元标签中，同时把标题和slug也放入描述元标签中。','content/BlogPost/2017/网络检索优化.md','2017-04-29 08:31:55','2017-04-30 00:21:38','wang-luo-jian-suo-you-hua','content/BlogPost/2017/网络检索优化.html','programming','');
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
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-01-01 15:55:18','1','测试',1,'',7,1),(2,'2017-01-01 15:55:53','1','写在2017元旦的2016总结',2,'Changed title, body, category and tags.',7,1),(3,'2017-01-01 16:45:00','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(4,'2017-01-01 16:52:51','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(5,'2017-01-01 16:53:06','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(6,'2017-01-01 17:06:30','1','写在2017元旦的2016总结',2,'Changed body and tags.',7,1),(7,'2017-01-12 15:30:43','1','程昌新现在不在，晒太阳去了？',2,'Changed title, body and tags.',7,1),(8,'2017-01-12 15:31:49','1','程昌新现在不在，晒太阳去了？',2,'Changed body and tags.',7,1),(9,'2017-01-18 15:39:47','1','写在2017元旦的2016总结 ',2,'Changed title, body and tags.',7,1),(10,'2017-01-18 15:40:53','2','春节假期充电',1,'',7,1),(11,'2017-01-18 15:42:59','2','春节假期充电',2,'Changed body and tags.',7,1),(12,'2017-01-18 16:08:17','3','shares',1,'',7,1),(13,'2017-01-18 16:09:57','3','shares',2,'Changed body and tags.',7,1),(14,'2017-01-19 14:06:55','2','春节假期充电',2,'Changed body and tags.',7,1),(15,'2017-01-19 15:35:51','2','春节假期充电',2,'Changed body and tags.',7,1),(16,'2017-01-19 16:08:17','2','春节假期充电',2,'Changed body and tags.',7,1),(17,'2017-01-19 23:13:18','2','春节假期充电',2,'Changed body and tags.',7,1),(18,'2017-01-20 02:24:27','2','春节假期充电',2,'Changed body and tags.',7,1),(19,'2017-01-20 02:26:53','2','春节假期充电',2,'Changed body and tags.',7,1),(20,'2017-01-20 02:27:59','2','春节假期充电',2,'Changed body and tags.',7,1),(21,'2017-01-20 02:32:16','2','春节假期充电',2,'Changed tags.',7,1),(22,'2017-01-20 02:33:11','2','春节假期充电',2,'Changed body and tags.',7,1),(23,'2017-01-20 02:33:58','2','春节假期充电',2,'Changed body and tags.',7,1),(24,'2017-01-20 02:35:35','2','春节假期充电',2,'Changed body and tags.',7,1),(25,'2017-01-20 02:36:03','2','春节假期充电',2,'Changed body and tags.',7,1),(26,'2017-01-20 15:23:13','2','春节假期充电',2,'Changed body and tags.',7,1),(27,'2017-01-20 15:42:53','4','现代礼仪学习笔记',1,'',7,1),(28,'2017-01-20 15:44:31','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(29,'2017-01-20 15:55:51','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(30,'2017-01-20 15:57:07','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(31,'2017-01-20 15:57:34','4','现代礼仪学习笔记',2,'Changed tags.',7,1),(32,'2017-01-20 15:57:59','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(33,'2017-01-21 00:23:30','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(34,'2017-01-21 00:24:35','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(35,'2017-01-21 00:24:51','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(36,'2017-01-21 00:25:06','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(37,'2017-01-21 00:56:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(38,'2017-01-21 01:13:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(39,'2017-01-21 01:15:17','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(40,'2017-01-21 01:16:41','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(41,'2017-01-21 01:38:44','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(42,'2017-01-21 01:47:38','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(43,'2017-01-21 01:49:35','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(44,'2017-01-21 01:50:14','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(45,'2017-01-21 01:56:57','3','shares',2,'Changed body and tags.',7,1),(46,'2017-01-21 01:57:55','3','shares',2,'Changed body and tags.',7,1),(47,'2017-01-21 01:58:26','3','shares',2,'Changed body and tags.',7,1),(48,'2017-01-21 01:58:52','3','shares',2,'Changed body and tags.',7,1),(49,'2017-01-21 02:18:54','3','shares',2,'Changed body and tags.',7,1),(50,'2017-01-21 02:19:17','3','shares',2,'Changed body and tags.',7,1),(51,'2017-01-21 03:00:29','3','shares',2,'Changed body and tags.',7,1),(52,'2017-01-21 04:57:49','3','shares',2,'Changed body and tags.',7,1),(53,'2017-01-21 08:24:25','3','shares',2,'Changed body and tags.',7,1),(54,'2017-01-21 23:45:24','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(55,'2017-01-21 23:55:53','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(56,'2017-01-22 00:51:45','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(57,'2017-01-22 01:03:52','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(58,'2017-01-22 01:06:16','4','现代礼仪学习笔记',2,'Changed body and tags.',7,1),(59,'2017-01-24 06:17:57','2','春节假期充电',2,'Changed body and tags.',7,1),(60,'2017-01-24 15:49:40','5','见字如面',1,'',7,1),(61,'2017-01-24 15:50:18','5','见字如面',2,'Changed body and tags.',7,1),(62,'2017-01-24 15:50:51','5','见字如面',2,'Changed body and tags.',7,1),(63,'2017-01-24 15:51:25','5','见字如面',2,'Changed body and tags.',7,1),(64,'2017-01-24 15:51:37','5','见字如面',2,'Changed tags.',7,1),(65,'2017-01-29 14:41:40','6','记一件没有意义的事情',1,'',7,1),(66,'2017-03-23 14:50:44','7','源码计划',1,'',7,1),(67,'2017-03-31 07:08:34','3','shares',2,'Changed body and tags.',7,1),(68,'2017-03-31 08:08:28','6','记一件没有意义的事情',3,'',7,1),(69,'2017-03-31 08:11:25','4','现代礼仪学习笔记',3,'',7,1),(70,'2017-03-31 08:28:27','7','源码计划',2,'Changed body and tags.',7,1),(71,'2017-03-31 08:30:39','7','源码计划',2,'Changed body and tags.',7,1),(72,'2017-03-31 08:31:04','7','源码计划',2,'Changed body and tags.',7,1),(73,'2017-03-31 08:32:14','3','shares',2,'Changed body and tags.',7,1),(74,'2017-03-31 08:33:37','3','shares',2,'Changed body and tags.',7,1),(75,'2017-03-31 09:04:16','7','源码计划',2,'Changed body and tags.',7,1),(76,'2017-04-27 16:54:00','8','python中的延迟',1,'',7,1),(77,'2017-04-27 17:11:25','8','python中的延迟',2,'Changed body and tags.',7,1),(78,'2017-04-27 17:12:10','8','python中的延迟',2,'Changed body and tags.',7,1),(79,'2017-04-28 02:51:20','8','python中的延迟',2,'Changed body and tags.',7,1),(80,'2017-04-28 02:54:32','8','python中的延迟',2,'Changed body and tags.',7,1),(81,'2017-04-28 02:57:51','8','python中的延迟',2,'Changed tags.',7,1),(82,'2017-04-28 06:23:51','8','python中的延迟',2,'Changed body and tags.',7,1),(83,'2017-04-28 06:24:37','8','python中的延迟',2,'Changed body and tags.',7,1),(84,'2017-04-29 02:11:53','8','python中的延迟',2,'Changed body and tags.',7,1),(85,'2017-04-29 02:17:49','8','python中的延迟',2,'Changed body and tags.',7,1),(86,'2017-04-29 02:18:40','8','python中的延迟',2,'Changed body and tags.',7,1),(87,'2017-04-29 02:19:21','8','python中的延迟',2,'Changed body and tags.',7,1),(88,'2017-04-29 02:20:57','8','python中的延迟',2,'Changed body and tags.',7,1),(89,'2017-04-29 08:30:02','8','python中的延迟',2,'Changed tags.',7,1),(90,'2017-04-29 08:31:55','9','网络检索优化',1,'',7,1),(91,'2017-04-29 10:06:26','9','网络检索优化',2,'Changed tags.',7,1),(92,'2017-04-29 10:06:33','9','网络检索优化',2,'Changed tags.',7,1),(93,'2017-04-29 10:09:07','8','python中的延迟',2,'Changed tags.',7,1),(94,'2017-04-29 10:53:44','8','python中的延迟',2,'Changed body and tags.',7,1),(95,'2017-04-29 11:05:23','8','python中的延迟',2,'Changed body and tags.',7,1),(96,'2017-04-29 11:06:04','8','python中的延迟',2,'Changed body and tags.',7,1),(97,'2017-04-29 11:07:34','8','python中的延迟',2,'Changed body and tags.',7,1),(98,'2017-04-29 11:08:06','8','python中的延迟',2,'Changed body and tags.',7,1),(99,'2017-04-29 11:10:07','8','python中的延迟',2,'Changed body and tags.',7,1),(100,'2017-04-29 11:10:36','8','python中的延迟',2,'Changed body and tags.',7,1),(101,'2017-04-29 11:21:24','8','python中的延迟',2,'Changed body and tags.',7,1),(102,'2017-04-29 11:42:34','8','python中的延迟',2,'Changed md_file and tags.',7,1),(103,'2017-04-29 11:56:27','8','python中的延迟',2,'Changed tags.',7,1),(104,'2017-04-29 11:56:49','8','python中的延迟',2,'Changed body and tags.',7,1),(105,'2017-04-29 12:09:29','9','网络检索优化',2,'Changed tags.',7,1),(106,'2017-04-29 12:19:52','9','网络检索优化',2,'Changed tags.',7,1),(107,'2017-04-29 17:34:13','9','网络检索优化',2,'Changed body and tags.',7,1),(108,'2017-04-30 00:19:02','9','网络检索优化',2,'Changed body and tags.',7,1),(109,'2017-04-30 00:21:38','9','网络检索优化',2,'Changed tags.',7,1);
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
INSERT INTO `django_session` VALUES ('9ys98v5n8o650uz16p1fggj8phr5huiv','YzEwYzVhYzlmZGUxZWRkODgxYjgzNDQ5Nzk0MWI5NWY5OGZmNDk4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmU1NzE5Y2EyMjJiZDA2ZWVkYmVlNzJmMTFjYmVlZGZmNDNlOTZmNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-05-13 10:56:47'),('acui8xdq7zfy9wdjrunvto30p906gqrg','YzEwYzVhYzlmZGUxZWRkODgxYjgzNDQ5Nzk0MWI5NWY5OGZmNDk4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmU1NzE5Y2EyMjJiZDA2ZWVkYmVlNzJmMTFjYmVlZGZmNDNlOTZmNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-05-11 15:11:58'),('b6i89dq9k4xqz4exx1hdl307z0g0cl3i','NzA4OTAyNGY3YWNjMjdhMWU4MzUwOTU4Yjg0MTA0OWZmZDY3MDYwNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-05-14 00:18:49'),('bpvk8ly43qacowund9kelxnhtqkbbcin','NzA4OTAyNGY3YWNjMjdhMWU4MzUwOTU4Yjg0MTA0OWZmZDY3MDYwNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-04-06 14:48:54'),('d3z8ijnokvy5tsv4vkg66q5ybxg8086h','ZjFmOTdiNjRlMTU4ZjgxZDEyNWUxYzkwODkyYzkwOTMxMjQxYTQ1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiJiZTU3MTljYTIyMmJkMDZlZWRiZWU3MmYxMWNiZWVkZmY0M2U5NmY0In0=','2017-01-15 16:52:38'),('ee3c8b4c5s04ldaxnv11ujrfsf74j452','YzEwYzVhYzlmZGUxZWRkODgxYjgzNDQ5Nzk0MWI5NWY5OGZmNDk4Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmU1NzE5Y2EyMjJiZDA2ZWVkYmVlNzJmMTFjYmVlZGZmNDNlOTZmNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-05-11 17:10:24'),('emxbzpxueqqk9e7lilegwhzmsknvqg3o','YmRmMzYzZjQwNjEzNDk2MjE0OGM3ZDY4OWM2NDBlOTAxNDMwNzZlNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-02-02 15:35:13'),('ln53uftuizys3m3loyjzlr3nd9ohomvx','NzA4OTAyNGY3YWNjMjdhMWU4MzUwOTU4Yjg0MTA0OWZmZDY3MDYwNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-04-14 07:06:09'),('uf0tmy9bwnz3144x4e17clw9rwlsmnp9','YmRmMzYzZjQwNjEzNDk2MjE0OGM3ZDY4OWM2NDBlOTAxNDMwNzZlNDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJlNTcxOWNhMjIyYmQwNmVlZGJlZTcyZjExY2JlZWRmZjQzZTk2ZjQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-03-20 13:51:40');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_tag`
--

LOCK TABLES `taggit_tag` WRITE;
/*!40000 ALTER TABLE `taggit_tag` DISABLE KEYS */;
INSERT INTO `taggit_tag` VALUES (1,'python','python'),(2,'summary','summary'),(3,'grow-up','grow-up'),(4,'shares','shares'),(5,'etiquette','etiquette'),(6,'letter','letter'),(7,'study','study'),(8,'twisted','twisted'),(9,'generator','generator'),(10,'search optimize','search-optimize'),(11,'web','web'),(12,'SEO','seo'),(13,'search-engine-optimization','search-engine-optimization');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_taggeditem`
--

LOCK TABLES `taggit_taggeditem` WRITE;
/*!40000 ALTER TABLE `taggit_taggeditem` DISABLE KEYS */;
INSERT INTO `taggit_taggeditem` VALUES (2,1,7,2),(3,2,7,3),(4,3,7,4),(6,5,7,6),(8,7,7,8),(9,7,7,1),(10,8,7,1),(11,8,7,9),(13,9,7,11),(15,9,7,13);
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

-- Dump completed on 2017-04-30  8:29:21
