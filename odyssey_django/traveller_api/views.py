from django.shortcuts import get_object_or_404
from django.db.models import Q
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import MultiPartParser
from post.serializers import PostSerializer
from blogs.serializers import BlogSerializer
from notification.models import Notification, Notification_type
from .serializers import TravellerSerializer, TravellerSerializerPublic
from .serializers_profile import (
        TravellerSerializerProfileViewPrivate,
        TravellerSerializerProfileViewPublic
    )
from .models import Traveller, TravellerFollowing
import time

class TravellerView(APIView):
    parser_classes = [MultiPartParser] 

    def get(self, request):
        traveller = get_object(request)
        traveller_email = request.user.email
        serializer = TravellerSerializer(traveller).data
        serializer.update({'email':traveller_email})
        return Response(serializer)

    def put(self, request):
        traveller = get_object(request)
        request.data._mutable = True
        request.data["first_name"] = request.data["first_name"].title()
        request.data["last_name"] = request.data["last_name"].title()
        request.data._mutable = False
        serializer = TravellerSerializer(traveller, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request):
        traveller = get_object(request)
        traveller.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class TravellerGetView(APIView):
    def get(self, request, username):
        try:
            traveller = Traveller.objects.get(username__username=username)
            current_user = Traveller.objects.get(username = request.user)
            traveller_followers = traveller.get_followers()
            total_posts = traveller.get_posts_count()
            total_blogs = traveller.get_blogs_count()
            blogs = traveller.get_blogs()
            blog_serializer = BlogSerializer(blogs, many =True)
            if current_user in traveller_followers:
                posts = traveller.get_posts()
                post_serializer = PostSerializer(
                        posts,
                        many=True,
                        context = {"traveller":current_user}
                    )
                serializer_dict = TravellerSerializerProfileViewPrivate(
                        traveller,
                        context = {"traveller": current_user}
                        ).data
            else:
                public_posts = traveller.get_public_posts()
                post_serializer = PostSerializer(
                        public_posts,
                        many=True,
                        context = {"traveller":current_user}
                    )
                serializer = TravellerSerializerProfileViewPublic(
                        traveller,
                        context = {"traveller": current_user}
                        )
                serializer_dict = serializer.data
            serializer_dict.update(
                    {
                        "number of posts":total_posts,
                        "number of blogs":total_blogs,
                        "posts": post_serializer.data,
                        "blogs": blog_serializer.data
                    }
                )
            return Response(serializer_dict)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)



class FollowView(APIView):
    def put(self, request, username):
        try:
            new_following = Traveller.objects.get(username__username=username)
            user = Traveller.objects.get(username = request.user)
            # add following to currect user
            if new_following in user.get_following():
                following =TravellerFollowing.objects.get(
                        traveller_id = user,
                        following_traveller_id = new_following
                    )
                following.delete()
                notification(user, new_following, remove = True)
                message = False
            else:
                following =TravellerFollowing(
                        traveller_id = user,
                        following_traveller_id = new_following
                    )
                following.save()
                notification(user, new_following)
                message = True
            return Response(
                    {
                        "following":message
                    },
                    status=status.HTTP_202_ACCEPTED
                )
        except Traveller.DoesNotExist:
            return Response( {
                    "error": True,
                    "error_msg": "Traveller not found"
                },
                status=status.HTTP_404_NOT_FOUND
            )
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetFollowers(APIView):
    def get(self, request):
        followers = Traveller.objects.get(username = request.user).get_followers()
        print(followers)
        serializer = TravellerSerializerPublic(followers, many=True)
        return Response(
                serializer.data,
                status = status.HTTP_200_OK
            )


class GetFollowing(APIView):
    def get(self, request):
        following = Traveller.objects.get(username = request.user).get_following()
        serializer = TravellerSerializerPublic(following, many=True)
        return Response(
                serializer.data,
                status = status.HTTP_200_OK
            )

def get_object(request):
    try:
        user = request.user
        return get_object_or_404(Traveller, username=user)
        #return Traveller.objects.get(username=user)
    except Traveller.DoesNotExist:
        return Response(status=status.HTTP_400_BAD_REQUEST)

def notification(sender, receipent, remove = False):
    if sender == receipent:
        return False
    noti_type, _created = Notification_type.objects.get_or_create(
                        category = "FOLLOW",
                    )
    follow_notification, _create = Notification.objects.get_or_create(
                sender = sender,
                receipent = receipent,
                noti_type = noti_type
            )
    if remove:
        print(noti_type.notification)
        if noti_type.notification.count() > 1:
            return follow_notification.delete()
        return follow_notification.noti_type.delete()

    return follow_notification

class SearchTraveller(APIView):
    def get(self, request):
        searchtag = request.GET.get("traveller")
        travellers = Traveller.objects.filter(
                Q(first_name__icontains=searchtag) |
                Q(last_name__icontains=searchtag) |
                Q(username__username__icontains=searchtag),
                ~Q(username = request.user)
            )
        serializer = TravellerSerializerPublic(travellers, many = True)
        return Response(serializer.data)
