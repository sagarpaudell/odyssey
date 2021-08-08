from rest_framework import serializers
from traveller_api.serializers import TravellerSerializerPublic
from places_api.serializers import PlaceSerializer, PlaceSerializerNewsFeed
from .models import Blog, BlogComment

class BlogCommentSerializer(serializers.ModelSerializer):
    # blog = BlogSerializer(read_only=True)
    user = TravellerSerializerPublic(read_only=True)
    class Meta:
        model = BlogComment
        fields = ['id','user','comment','liked_users','disliked_users','comment_time']

class BlogSerializer(serializers.ModelSerializer):
    is_bookmarked = serializers.SerializerMethodField('check_bookmark')
    author = TravellerSerializerPublic(read_only=True)
    place = PlaceSerializerNewsFeed(read_only=True)
    comments = BlogCommentSerializer(read_only=True, many=True)
    like_users = serializers.StringRelatedField(
            read_only=True,
            many = True
        )
    def check_bookmark(self, obj):
        traveller = self.context.get("traveller")
        if traveller:
            return obj.is_bookmarked(traveller)
        return False
    class Meta:
        model = Blog
        fields = ('id','title','author','place','description','date',
                'like_users','photo1','photo2','photo3','photo4','comments',
                'is_bookmarked')
