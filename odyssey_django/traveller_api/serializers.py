from rest_framework import serializers
from .models import Traveller

class TravellerSerializer(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    # following = serializers.StringRelatedField(many = True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name', 'address', 
                'city', 'country', 'bio', 'contact_no', 'gender', 'photo_main']


class PublicTravellerSerializer(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name', 'photo_main']
                
