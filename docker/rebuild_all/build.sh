#!/usr/bin/env bash
if [ ! -d "myblog" ]; then
  echo "Downloading myblog"
  git clone https://github.com/chengcx1019/MyBlog.git myblog

else
  echo "Dependencies found, skipping retrieval..."
fi

docker build . -t blog


