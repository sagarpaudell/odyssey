from rest_framework import serializers
from traveller_api.serializers import TravellerSerializer
from .models import Chat

class ChatSerializer(serializers.ModelSerializer):
    sender = TravellerSerializer(read_only=True)
    receiver = TravellerSerializer(read_only=True)
    class Meta:
        model = Chat
        fields = ('sender', 'receiver', 'message_text', 'message_time', 'message_seen',
                'message_seen_time',)
