from django.db import models

# Create your models here.


class StockRecord(models.Model):
    stock_code = models.CharField(max_length=150)
    company_name = models.TextField(blank=True)
    in_price=models.FloatField(blank=False)
    out_price=models.FloatField(blank=False)
    out_number = models.IntegerField(blank=False)
    excepted_in_price = models.FloatField(blank=False)
    excepted_in_number=models.IntegerField(blank=True)
    pub_date = models.DateTimeField('date published', auto_now_add=True)
    last_edit_date = models.DateTimeField('last edited', auto_now=True)
    description = models.TextField(blank=True)
    show = models.IntegerField(blank=True,default=0)
    focus_on = models.BooleanField(blank=False,default=False)
