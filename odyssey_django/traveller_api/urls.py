from django.urls import path
from .views import TravellerView

urlpatterns = [
    path('', TravellerView.as_view(), name='Traveller'),
]
