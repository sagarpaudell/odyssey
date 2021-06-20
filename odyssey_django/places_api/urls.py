from django.urls import path
from .views import MajorAttractionView, PlaceView

urlpatterns = [
    path('<int:id>', PlaceView.as_view(), name='Place'),
    path('major-attractions/<int:id>', MajorAttractionView.as_view(), name='MajorAttractions'),
]