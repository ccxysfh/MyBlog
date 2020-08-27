FROM chengcx/blog:v3

USER root



WORKDIR /data/myblog

RUN git pull origin master

RUN cd /data/myblog && pip install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt

RUN  cd /data/myblog/front && npm run build

RUN cd /data/myblog &&  python manage.py collectstatic --noinput

CMD uwsgi --ini /data/myblog/deploy_uwsgi.ini