from django.contrib.auth.models import User
from rest_framework import fields, serializers
from rest_framework.validators import UniqueTogetherValidator
from rest_framework.permissions import IsAuthenticated
from .models import OTP

class UserSerializer(serializers.ModelSerializer):
    permission_classes = [IsAuthenticated]
    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user
    class Meta:
        model = User
        fields = (
                'id',
                'username',
                'first_name',
                'last_name',
                'email',
                )
        validators = [
                UniqueTogetherValidator(
                    queryset=User.objects.all(),
                    fields=['username', 'email']
                    )
                ]


class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = OTP
        fields = ['verified_email']