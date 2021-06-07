from django.contrib import admin
from .models import Traveller

class TravellerAdmin(admin.ModelAdmin):
    list_display = ('id','first_name','last_name','username','address')
    list_display_links = ('id', 'username')

admin.site.register(Traveller, TravellerAdmin)