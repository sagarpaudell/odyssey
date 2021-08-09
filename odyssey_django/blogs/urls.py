from django.urls import path
from .views import (
        AddBlogComment, BlogCommentDetail, BlogLikeView, MyBlogs,BlogDetail,
        AddBlog, NewsfeedBlogs, ViewBlogs, BookMarkBlogView, BookMarkView,
        BlogByPlaceView
    )

urlpatterns=[
        path('', ViewBlogs.as_view()),
        path('feedblogs',NewsfeedBlogs.as_view()),
        path('myblogs', MyBlogs.as_view()),
        path('<int:id>', BlogDetail.as_view()),
        path('addblogs', AddBlog.as_view()),
        #id of blog comment
        path('blogcommentdetail/<int:id>', BlogCommentDetail.as_view()),
        #id of blog
        path('addblogcomment/<int:id>', AddBlogComment.as_view()),
        path('bookmarked', BookMarkBlogView.as_view()),
        path('bookmark/<int:id>', BookMarkView.as_view()),
        path('likeblog/<int:id>', BlogLikeView.as_view()),
        path('place/<int:id>', BlogByPlaceView.as_view()),
]
