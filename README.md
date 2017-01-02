# myblog
##Django+MySQL+uWSGI搭建个人博客
###网站还在建设中，暂不附链接
###添加知识记忆卡片分支
###数据库操作
**mysql**
```
备份：mysqldump -uroot -p maksim >maksim.sql
还原：mysql -hhostname -uusername -ppassword databasename < backupfile.sql

First Connect to the mysql usting "mysql" command.
Run the below script to check the current installed character set.                                                    
  
show variables like “collation_database”;
 
+--------------------+-------------------+
| Variable_name      | Value             |
+--------------------+-------------------+
| collation_database | latin1_swedish_ci |
+--------------------+-------------------+

show variables like "%character%"; show variables like "%collation%";

+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | latin1                     |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | latin1                     |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.12 sec)

+----------------------+-------------------+
| Variable_name        | Value             |
+----------------------+-------------------+
| collation_connection | utf8_general_ci   |
| collation_database   | latin1_swedish_ci |
| collation_server     | latin1_swedish_ci |
+----------------------+-------------------+
3 rows in set (0.00 sec)

 Add below variables in my.cnf which is in the /etc/mysql directory
[mysqld]
init_connect='SET collation_connection = utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake
Restart the MySQL
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql start
Re-run the above SQL statements which is define in the step 2. You will see the char set have been changed to utf8 as below
+--------------------+-----------------+
| Variable_name      | Value           |
+--------------------+-----------------+
| collation_database | utf8_unicode_ci |
+--------------------+-----------------+
1 row in set (0.00 sec)

+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec)

+----------------------+-----------------+
| Variable_name        | Value           |
+----------------------+-----------------+
| collation_connection | utf8_general_ci |
| collation_database   | utf8_unicode_ci |
| collation_server     | utf8_unicode_ci |
+----------------------+-----------------+
3 rows in set (0.00 sec)

```