from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import StockRecord


class StockRecordAdmin(admin.ModelAdmin):
    list_display = ('stock_code','stock_name','status',
                    'type','in_price','in_number',
                    'out_price','out_number','excepted_next_price',
                    'excepted_next_number','description','show','focus_on','pub_date','last_edit_date'
                    )
    list_filter = ('stock_code','status','type','focus_on','show')

admin.site.register(StockRecord, StockRecordAdmin)
