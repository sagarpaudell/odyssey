from django.contrib import admin
from .models import Notification, Notification_type

# Register your models here.
class NotificationAdmin(admin.ModelAdmin):
    list_display = ('sender', 'receipent', 'noti_type', 'time', 'is_new', 'is_read')
    list_display_links = ('sender', 'receipent')
    list_filter = ('sender','receipent', 'time', 'is_new', 'is_read')

class Notification_typeAdmin(admin.ModelAdmin):
    list_display = ('category',)
    list_display_links = ('category',)
    list_filter = ('category',)

admin.site.register(Notification, NotificationAdmin)
admin.site.register(Notification_type, Notification_typeAdmin)
