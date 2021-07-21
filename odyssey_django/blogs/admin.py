from django.contrib import admin
from .models import Blog,BlogComment


class Blog_Admin(admin.ModelAdmin):
    list_display = ('id','title', 'author','place')
    list_display_links = ('id','title')


class Blog_Comment_Admin(admin.ModelAdmin):
    list_display = ('id', 'blog' ,'user',)
    list_display_links = ('id', 'blog',)


admin.site.register(Blog, Blog_Admin)
admin.site.register(BlogComment, Blog_Comment_Admin)

