from django.contrib import admin
from .models import Blog,BlogComment, Blog_notification


class Blog_Admin(admin.ModelAdmin):
    list_display = ('id','title', 'author','place')
    list_display_links = ('id','title')


class Blog_Comment_Admin(admin.ModelAdmin):
    list_display = ('id', 'blog' ,'user',)
    list_display_links = ('id', 'blog',)

class Blog_notification_Admin(admin.ModelAdmin):
    list_display = ('id', 'blog_id' ,'is_like','is_comment')
    list_display_links = ('id',)

admin.site.register(Blog, Blog_Admin)
admin.site.register(BlogComment, Blog_Comment_Admin)
admin.site.register(Blog_notification, Blog_notification_Admin)
