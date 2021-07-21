from blogs.models import BlogComment
from django.urls import path
from .views import AddBlogComment, BlogCommentDetail, MyBlogs,BlogDetail, AddBlog, ViewBlogComment

urlpatterns=[
        path('myblogs', MyBlogs.as_view()),
        path('<int:id>', BlogDetail.as_view()),
        path('addblogs', AddBlog.as_view()),
        path('blogcomments/<int:id>', ViewBlogComment.as_view()),
        path('blogcommentdetail/<int:id>', BlogCommentDetail.as_view()),      #id of blog comment
        path('addblogcomment/<int:id>', AddBlogComment.as_view())             #id of blog
]
