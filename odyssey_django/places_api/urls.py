from django.urls import path
from .views import (
        AllPlaceView, MajorAttractionView, PlaceView, SearchPlace
    )

urlpatterns = [
    path('', AllPlaceView.as_view(), name = 'All Place'),
    path('<int:id>', PlaceView.as_view(), name='Place'),
    path('major-attractions/<int:id>', MajorAttractionView.as_view(), name='MajorAttractions'),
    path('search', SearchPlace.as_view()),
]
