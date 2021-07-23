from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from rest_framework.permissions import IsAuthenticated
from traveller_api.serializers import TravellerSerializer, TravellerSerializerPrivate, TravellerSerializerPublic
from places_api.serializers import PlaceSerializer
from .models import Post, Comment

class CommentSerializer(ModelSerializer):
    traveller = TravellerSerializerPublic(read_only = True)
    class Meta:
        model = Comment
        fields=("traveller", "comment", "comment_time")

class PostSerializer(ModelSerializer):
    traveller = TravellerSerializerPublic(read_only = True)
    place = PlaceSerializer(read_only=True)
    comments = CommentSerializer(read_only=True, many=True)

    permissions_classes = [IsAuthenticated]

    # def create(self, validated_data, traveller, place):
        # """ create new posts """
        # print (validated_data)
        # photo = validated_data.pop("photo")
        # post = Post.objects.create(photo = photo[0], traveller = traveller,
                # place = place, **validated_data)
        # post.save()
        # print(post)
        # return PostSerializer(post)

    class Meta:
        model = Post
        fields=("id", "traveller", "caption", "photo", "place", "like_users",
                "comments", "post_time")