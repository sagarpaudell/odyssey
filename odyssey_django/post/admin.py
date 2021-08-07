from django.contrib import admin
from .models import Post, Comment, Post_notification


# Register your models here.
class PostAdmin(admin.ModelAdmin):
    list_display = ('id', 'caption', 'traveller', 'post_time',  'public_post')
    list_display_links = ('id','caption', 'traveller')
    list_filter = ('traveller', 'post_time',)

class CommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'traveller')
    list_display_links = ('id','traveller' )
    list_filter = ('traveller', 'post_id', 'comment_time')

class Post_notificationAdmin(admin.ModelAdmin):
    list_display = ('id', 'post_id' ,'is_like','is_comment')
    list_display_links = ('id',)

admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Post_notification, Post_notificationAdmin)
