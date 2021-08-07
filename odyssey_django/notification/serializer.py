from rest_framework import serializers
from traveller_api.serializers import TravellerSerializerPublic
from places_api.serializers import PlaceSerializer
from .models import Notification, Notification_type

class Notification_typeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification_type
        fields = ['category', 'blog_noti', 'post_noti']
        depth = 1

class NotificationSerializer(serializers.ModelSerializer):
    sender = TravellerSerializerPublic(read_only = True)
    receipent = TravellerSerializerPublic(read_only = True)
    noti_type = Notification_typeSerializer()
    class Meta:
        model = Notification
        fields = '__all__'

