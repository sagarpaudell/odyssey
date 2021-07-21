from django.urls import path
from post.views import ( PostView, NewsfeedView, SelfPostView)

urlpatterns = [
    path('newsfeed', NewsfeedView.as_view()),
    path('post/', SelfPostView.as_view()),
    path('post/<int:id>', PostView.as_view()),
]
