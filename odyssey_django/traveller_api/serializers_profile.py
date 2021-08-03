from rest_framework import serializers
from .models import Traveller
# from post.serializers import PostSerializer
# from blogs.serializers import BlogSerializer

class TravellerSerializerProfileViewPublic(serializers.ModelSerializer):
    username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    follower_count = serializers.SerializerMethodField('get_follower_count')
    following_count = serializers.SerializerMethodField('get_following_count')
    following = serializers.SerializerMethodField('check_following')

    def get_follower_count(self, obj):
        return len(obj.get_followers())

    def get_following_count(self, obj):
        return len(obj.get_following())

    def check_following(self, obj):
        traveller = self.context.get("traveller")
        if traveller:
            return bool(obj in traveller.get_following())
        return False

    class Meta:
        model = Traveller
        fields = ['username', 'id', 'first_name', 'last_name','address','bio',
                'photo_main', 'follower_count', 'following_count', 'following']

class TravellerSerializerProfileViewPrivate(TravellerSerializerProfileViewPublic):
    class Meta:
        model = Traveller
        fields = ['username',  'first_name', 'last_name','address','city',
                'country','bio','gender', 'photo_main', 'following',
                'follower_count', 'following_count']

# class TravellerSerializerProfileViewSelf(serializers.ModelSerializer):
    # username = serializers.SlugRelatedField(slug_field='username', read_only=True)
    # posts = PostSerializer(read_only=True, many=True)
    # blogs = BlogSerializer(read_only=True, many=True)
    # follower_count = serializers.SerializerMethodField('get_follower_count')
    # following_count = serializers.SerializerMethodField('get_following_count')
    # def get_follower_count(self, obj):
        # return len(obj.get_followers())
    # def get_following_count(self, obj):
        # return len(obj.get_following())
    # class Meta:
        # model = Traveller
        # fields = ['username', 'id', 'first_name', 'last_name','address','city',
                # 'country','bio','contact_no', 'gender', 'photo_main', 'posts',
                # 'blogs', 'follower_count', 'following_count']
