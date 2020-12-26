import os

from celery import Celery

import config

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")
app = Celery("config")
app.config_from_object("django.conf:settings")
app.autodiscover_tasks(lambda: config.settings.INSTALLED_APPS)


