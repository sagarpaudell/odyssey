from django.urls import path
from .views import (
        TravellerGetView, TravellerView, FollowView, GetFollowers,
        GetFollowing, SearchTraveller
    )


urlpatterns = [
    path('', TravellerView.as_view()),
    path('followers', GetFollowers.as_view()),
    path('following', GetFollowing.as_view()),
    path('follow-user/<str:username>', FollowView.as_view()),
    path('search', SearchTraveller.as_view()),
    path('<str:username>', TravellerGetView.as_view()),
]
