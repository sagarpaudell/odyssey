from django.contrib import admin
from .models import Place, Major_Attraction


class PlaceAdmin(admin.ModelAdmin):
    list_display = ('id','name', 'city','country', 'keywords', 'is_verified')
    list_display_links = ('id','name')
    list_filter = ('is_verified', 'city', 'country')


class Major_Attraction_Admin(admin.ModelAdmin):
    list_display = ('id', 'place' , 'attraction_name',)
    list_display_links = ('id', 'attraction_name',)


admin.site.register(Place, PlaceAdmin)
admin.site.register(Major_Attraction, Major_Attraction_Admin)
