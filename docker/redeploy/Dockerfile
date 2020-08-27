FROM chengcx/blog:latest

USER root



WORKDIR /data/myblog

RUN git config --global user.email "chengcx1019@gmail.com"
RUN git config --global user.name "Changxin Cheng"
RUN git stash
RUN git pull origin master

RUN cd /data/myblog && pip install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt

RUN  cd /data/myblog/front && npm run build



RUN cd /data/myblog &&  python manage.py collectstatic --noinput

CMD uwsgi --ini /data/myblog/deploy_uwsgi.ini