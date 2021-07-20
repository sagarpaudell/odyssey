from blogs.models import BlogComment
from django.urls import path
from .views import MyBlogs,BlogDetail, AddBlog, ViewBlogComment

urlpatterns=[
        path('myblogs', MyBlogs.as_view()),
        path('<int:id>', BlogDetail.as_view()),
        path('addblogs', AddBlog.as_view()),
        path('blogcomments/<int:id>', ViewBlogComment.as_view()),
]
