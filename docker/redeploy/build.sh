#!/usr/bin/env bash
echo "kill"
ps aux | grep uwsgi | awk '{print $2}' | xargs kill -9
echo "rebuild myblog"
docker build . --no-cache --network host -t blog:deploy
echo "start myblog"
docker run -d -it -v /data/myblog:/data/myblog blog:deploy
