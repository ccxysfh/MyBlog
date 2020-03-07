#!/usr/bin/env bash
ps aux | grep uwsgi | awk '{print $2}' | xargs kill -9
nohup uwsgi --ini deploy_uwsgi.ini &
