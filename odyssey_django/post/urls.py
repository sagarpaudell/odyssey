from django.urls import path
from post.views import (
        PostView, NewsfeedView, SelfPostView, BookMarkView, BookMarkPostView,
        LikeView, CommentView, ExploreView, PostByPlaceView
    )

urlpatterns = [
    path('newsfeed', NewsfeedView.as_view()),
    path('post', SelfPostView.as_view()),
    path('explore', ExploreView.as_view()),
    path('post/<int:id>', PostView.as_view()),
    path('bookmarked', BookMarkPostView.as_view()),
    path('bookmark/<int:id>', BookMarkView.as_view()),
    path('like/<int:id>', LikeView.as_view()),
    path('comment/<int:id>', CommentView.as_view()),
    path('place/<int:id>', PostByPlaceView.as_view()),
]
