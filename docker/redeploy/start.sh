#!/usr/bin/env bash
echo "redis"
/usr/bin/redis-server &
echo "start uwsgi"
uwsgi --ini /data/myblog/deploy_uwsgi.ini