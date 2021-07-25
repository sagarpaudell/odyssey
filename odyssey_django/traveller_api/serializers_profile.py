from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from .models import Traveller
from post.serializers import PostSerializer
from blogs.serializers import BlogSerializer

class TravellerSerializerProfileViewPublic(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    # public_posts = serializers.Field(read_only=True, source='get_public_posts')
    # def get_public_posts(self, obj):
    #     print (obj)
    #     return obj.get_public_posts()
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name','address','bio','photo_main']

class TravellerSerializerProfileViewPrivate(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name','address','city','country','bio','gender', 'photo_main']

class TravellerSerializerProfileViewSelf(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    posts = PostSerializer(read_only=True, many=True)
    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name','address','city','country','bio','contact_no', 'gender', 'photo_main','posts']