from rest_framework import serializers
from .models import Traveller

class TravellerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Traveller
        fields = ['first_name', 'last_name', 'address', 'city', 'country',
                'bio', 'contact_no', 'gender', 'photo_main']
