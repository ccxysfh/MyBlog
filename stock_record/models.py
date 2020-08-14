from django.db import models

# Create your models here.


class StockRecord(models.Model):
    stock_code = models.CharField(max_length=150)
    stock_name = models.TextField(blank=True)
    status = models.IntegerField('0-intention,1-action', default=1)
    type = models.IntegerField('1-in,2-out', default=2)
    in_price = models.FloatField(blank=True)
    in_number = models.IntegerField(blank=True)
    out_price = models.FloatField(blank=True)
    out_number = models.IntegerField(blank=True)
    excepted_in_price = models.FloatField(blank=True)
    excepted_in_number=models.IntegerField(blank=True)
    pub_date = models.DateTimeField('date published', auto_now_add=True)
    last_edit_date = models.DateTimeField('last edited', auto_now=True)
    description = models.TextField(blank=True)
    show = models.IntegerField(blank=True,default=0)
    focus_on = models.BooleanField(blank=False,default=False)
