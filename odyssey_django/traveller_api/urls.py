from django.urls import path
from .views import (
        TravellerGetView, TravellerView, FollowView, GetUserFollowers,
        GetUserFollowing, SearchTraveller, GetSelfFollowers, GetSelfFollowing
    )


urlpatterns = [
    path('', TravellerView.as_view()),
    path('followers', GetSelfFollowers.as_view()),
    path('following', GetSelfFollowing.as_view()),
    path('followers/<str:username>', GetUserFollowers.as_view()),
    path('following/<str:username>', GetUserFollowing.as_view()),
    path('follow-user/<str:username>', FollowView.as_view()),
    path('search', SearchTraveller.as_view()),
    path('<str:username>', TravellerGetView.as_view()),
]
