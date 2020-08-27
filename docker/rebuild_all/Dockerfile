FROM python:3.8.5-buster

USER root

RUN mkdir -p /data

COPY ./myblog /data/myblog


RUN /bin/bash -c "cd /data/myblog && pip install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN mkdir -p /data/logs

RUN /bin/bash -c "apt-get update  \
    && apt-get install -y  nodejs \
    && apt-get install -y npm "
RUN /bin/bash -c "cd /data/myblog/front\
    &&npm config set registry https://registry.npm.taobao.org \
    && npm cache verify \
    && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver"
