from django.urls import path
from .views import TravellerView

urlpatterns = [
    path('<int:id>', TravellerView.as_view(), name='Traveller'),
]
