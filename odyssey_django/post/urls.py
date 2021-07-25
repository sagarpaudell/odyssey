from django.urls import path
from post.views import ( 
        PostView, NewsfeedView, SelfPostView, BookMarkView, BookMarkPostView
    )

urlpatterns = [
    path('newsfeed', NewsfeedView.as_view()),
    path('post/', SelfPostView.as_view()),
    path('post/<int:id>', PostView.as_view()),
    path('bookmarked', BookMarkPostView.as_view()),
    path('bookmark/<int:id>', BookMarkView.as_view()),
]
