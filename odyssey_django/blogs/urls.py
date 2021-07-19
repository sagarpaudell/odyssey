from django.urls import path
from .views import MyBlogs,BlogDetail, AddBlog

urlpatterns=[
        path('myblogs', MyBlogs.as_view()),
        path('<int:id>', BlogDetail.as_view()),
        path('addblogs', AddBlog.as_view()),
]
