from django.contrib import admin
from chat.models import Chat

# Register your models here.
class ChatAdmin(admin.ModelAdmin):
    list_display = ('sender', 'receiver', 'message_time', 'message_seen')
    list_display_links = ('sender', 'receiver')
    list_filter = ('sender','receiver', 'message_time')

admin.site.register(Chat,ChatAdmin)

