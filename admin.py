from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *


# Register your models here.

class AccountAdmin(UserAdmin):
    list_display = ('email', 'username', 'date_joined', 'last_login', 'is_admin', 'is_staff')
    search_fields = ('email', 'username')
    readonly_fields = ('username', 'date_joined', 'last_login')

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


class CustomerAdmin(admin.ModelAdmin):
    list_display = ('name', 'shipping_address', 'phone')
    search_fields = ('name', 'phone')

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'stock')
    search_fields = ('name', 'price')

    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()


admin.site.register(Account, AccountAdmin)
admin.site.register(CustomerDetails, CustomerAdmin)
admin.site.register(ProductCategories)
admin.site.register(Product)
admin.site.register(CartItems)
admin.site.register(OrderDetails)
admin.site.register(Order)
admin.site.register(OrderHistory)
