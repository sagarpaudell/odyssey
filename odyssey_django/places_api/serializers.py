from django.db.models import fields
from rest_framework import serializers
from .models import Place, Major_Attraction

class PlaceSerializer(serializers.ModelSerializer):

    class Meta:
        model = Place
        fields = ['id','name','city','country','description','photo_1','photo_2','photo_3','photo_4', 'keywords']

class PlaceSerializerNewsFeed(serializers.ModelSerializer):

    class Meta:
        model = Place
        fields = ['id','name']


class MajorAttractionSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Major_Attraction
        fields = ['place','attraction_name','description','thing_to_do','place_to_visit']
