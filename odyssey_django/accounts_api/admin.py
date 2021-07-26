from django.contrib import admin
from .models import OTP

class OTPAdmin(admin.ModelAdmin):
    list_display = ('id','username','otp')
    list_display_links = ('id', 'username')

admin.site.register(OTP, OTPAdmin)