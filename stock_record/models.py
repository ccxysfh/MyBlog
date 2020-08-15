from django.db import models

# Create your models here.


class Stock(models.Model):
    stock_code = models.CharField(unique=True,max_length=150)
    stock_name = models.CharField(blank=True,max_length=150,default='')
    focus_on = models.BooleanField(blank=False,default=False)

class StockRecord(models.Model):
    stock_code = models.CharField(max_length=150)
    stock_name = models.CharField(blank=True,max_length=150,default='')
    status = models.IntegerField('0-intention,1-action', default=1)
    type = models.IntegerField('1-in,2-out', default=2)
    in_price = models.FloatField(blank=True,default=0)
    in_number = models.IntegerField(blank=True,default=0)
    out_price = models.FloatField(blank=True,default=0)
    out_number = models.IntegerField(blank=True,default=0)
    excepted_next_price = models.FloatField(blank=True,default=0) # 如果type为2，则为预期的下次买入价格，如果type为1，则为预期卖出价格
    excepted_next_number=models.IntegerField(blank=True,default=0)
    pub_date = models.DateTimeField('date published', auto_now_add=True)
    last_edit_date = models.DateTimeField('last edited', auto_now=True)
    description = models.TextField(blank=True,default='')
    show = models.BooleanField(blank=True,default=True)
    focus_on = models.BooleanField(blank=False,default=False)

    def save(self, *args, **kwargs):
        if self.stock_name =='':
            stock = Stock.objects.filter(stock_code=self.stock_code).first()
            if stock !=None:
                self.stock_name = stock.stock_name
        super().save(*args, **kwargs)
