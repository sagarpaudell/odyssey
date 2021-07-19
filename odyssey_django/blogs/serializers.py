from rest_framework import serializers
from traveller_api.serializers import TravellerSerializer
from places_api.serializers import PlaceSerializer
from .models import Blog, BlogComment

class BlogSerializer(serializers.ModelSerializer):
    author = TravellerSerializer(read_only=True)
    place = PlaceSerializer(read_only=True)
    class Meta:
        model = Blog
        fields = ['id','title','author','place','description','date','like_users','photo1','photo2','photo3','photo4',]

class BlogCommentSerializer(serializers.ModelSerializer):
    blog = BlogSerializer(read_only=True)
    comment_by = TravellerSerializer(read_only=True)
    class Meta:
        model = BlogComment
        fields = ['id','blog','comment_by','comment','liked_users','disliked_users','comment_time']