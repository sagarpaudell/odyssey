from django.contrib import admin
from .models import Post
from .models import Comment


# Register your models here.
class PostAdmin(admin.ModelAdmin):
    list_display = ('id', 'caption', 'traveller', 'post_time',)
    list_display_links = ('id','caption', 'traveller')
    list_filter = ('traveller', 'post_time',)

class CommentAdmin(admin.ModelAdmin):
    list_display = ('id', 'traveller')
    list_display_links = ('id','traveller' )
    list_filter = ('traveller', 'post_id', 'comment_time')

admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)
