from django.contrib import admin
from .models import Traveller, TravellerFollowing

class TravellerAdmin(admin.ModelAdmin):
    list_display = ('id','first_name','last_name','username','address')
    list_display_links = ('id', 'username')

class TravellerFollowingAdmin(admin.ModelAdmin):
    list_display = ('traveller_id','following_traveller_id')
    list_display_links = ('traveller_id', 'following_traveller_id')
    list_filter = ('traveller_id','following_traveller_id' )

admin.site.register(Traveller, TravellerAdmin)
admin.site.register(TravellerFollowing, TravellerFollowingAdmin)
