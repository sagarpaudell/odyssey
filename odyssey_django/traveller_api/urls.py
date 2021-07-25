from django.urls import path
from .views import TravellerGetView, TravellerView, FollowView


urlpatterns = [
    path('', TravellerView.as_view(), name='Traveller'),
    path('<str:username>', TravellerGetView.as_view(), name='Traveller'),
    path('follow-user/<str:username>', FollowView.as_view()),
]
