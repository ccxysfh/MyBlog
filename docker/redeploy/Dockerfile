FROM chengcx/blog:latest

USER root



WORKDIR /data/myblog

RUN git config --global user.email "chengcx1019@gmail.com"
RUN git config --global user.name "Changxin Cheng"
RUN git stash
RUN git pull origin master

RUN cd /data/myblog && pip install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt

RUN  cd /data/myblog/front \
    && npm install chromedriver --chromedriver_cdnurl=http://cdn.npm.taobao.org/dist/chromedriver \
    && npm run build



RUN apt-get install -y redis-server

RUN cd /data/myblog &&  python manage.py collectstatic --noinput

COPY ./start.sh /data/myblog/start.sh
CMD /data/myblog/start.sh