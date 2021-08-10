from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from rest_framework.permissions import IsAuthenticated
from traveller_api.serializers import (
        TravellerSerializer, TravellerSerializerPrivate, 
        TravellerSerializerPublic
    )
from places_api.serializers import PlaceSerializer, PlaceSerializerNewsFeed
from places_api.models import Place
from .models import Post, Comment
from blogs.models import Blog


class CommentSerializer(ModelSerializer):
    traveller = TravellerSerializerPublic(read_only = True)
    class Meta:
        model = Comment
        fields=("id","traveller", "comment", "comment_time")

class PostSerializer(ModelSerializer):
    is_bookmarked = serializers.SerializerMethodField('check_bookmark')
    traveller = TravellerSerializerPublic(read_only = True)
    like_users = serializers.StringRelatedField(
            read_only=True,
            many = True
        )
    place = PlaceSerializerNewsFeed(read_only=True)
    comments = CommentSerializer(read_only=True, many=True)
    permissions_classes = [IsAuthenticated]
    def check_bookmark(self, obj):
        traveller = self.context.get("traveller")
        if traveller:
            return obj.is_bookmarked(traveller)
        return False

    class Meta:
        model = Post
        fields=("id", "traveller", "caption", "photo", "place", "like_users",
                "comments", "post_time", "is_bookmarked", "public_post")
