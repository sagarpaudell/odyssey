from blogs.models import BlogComment
from django.urls import path
from .views import AddBlogComment, BlogCommentDetail, MyBlogs,BlogDetail, AddBlog, ViewBlogs

urlpatterns=[
        path('', ViewBlogs.as_view()),
        path('myblogs', MyBlogs.as_view()),
        path('<int:id>', BlogDetail.as_view()),
        path('addblogs', AddBlog.as_view()),
        path('blogcommentdetail/<int:id>', BlogCommentDetail.as_view()),      #id of blog comment
        path('addblogcomment/<int:id>', AddBlogComment.as_view())             #id of blog
]
