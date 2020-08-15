from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import StockRecord, Stock


class StockRecordAdmin(admin.ModelAdmin):
    list_display = ('stock_code','stock_name','status',
                    'type','in_price','in_number',
                    'out_price','out_number','excepted_next_price',
                    'excepted_next_number','description','show','focus_on','pub_date','last_edit_date'
                    )
    list_editable = ('stock_name','focus_on','status','in_price','in_number',
                    'out_price','out_number','excepted_next_price',
                    'excepted_next_number','show')

    list_filter = ('stock_code','status','type','focus_on','show')

class StockAdmin(admin.ModelAdmin):
    list_display = ('stock_code','stock_name','focus_on')
    list_editable = ('stock_name','focus_on')
    list_filter = ('stock_code','focus_on')


admin.site.register(StockRecord, StockRecordAdmin)
admin.site.register(Stock, StockAdmin)
