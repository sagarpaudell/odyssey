from rest_framework import serializers
from .models import Traveller

class TravellerSerializer(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    # following = serializers.StringRelatedField(many = True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name', 'address',
                'city', 'country', 'bio', 'contact_no', 'gender', 'photo_main']


class TravellerSerializerPublic(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name','address','bio',
                 'photo_main']

class TravellerSerializerPrivate(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name', 'address',
                'city', 'country', 'bio','gender', 'photo_main']
