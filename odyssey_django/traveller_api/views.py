from post.serializers import PostSerializer
from django.shortcuts import render, get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from rest_framework.parsers import MultiPartParser
from django.shortcuts import get_object_or_404

from .serializers import TravellerSerializer, TravellerSerializerPublic
from .serializers_profile import TravellerSerializerProfileViewPrivate,TravellerSerializerProfileViewPublic,TravellerSerializerProfileViewSelf
from .models import Traveller, TravellerFollowing


class TravellerView(APIView):
    parser_classes = [MultiPartParser]

    def get(self, request):
        traveller = get_object(request)
        serializer = TravellerSerializerProfileViewSelf(traveller)
        return Response(serializer.data)

    def put(self, request):
        traveller = get_object(request)
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
            friend_user = User.objects.filter(username=username).first()
            traveller = Traveller.objects.get(username=friend_user)
            current_user = Traveller.objects.get(username = request.user)
            traveller_followers = traveller.get_followers()
            current_user_followers = current_user.get_followers()
            if (traveller in current_user_followers and current_user in traveller_followers):
                serializer_dict = TravellerSerializerProfileViewPrivate(traveller).data
            else:
                try:
                    public_posts = traveller.get_public_posts()
                    post_serializer = PostSerializer(public_posts)
                    print(post_serializer)
                    serializer = TravellerSerializerProfileViewPublic(traveller)
                    serializer_dict = serializer.data
                    serializer_dict.update({"posts": post_serializer.data})
                except:
                    serializer_dict = TravellerSerializerProfileViewPublic(traveller).data
            return Response(serializer_dict)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)



class FollowView(APIView):
    def get(self, request, username):
        try:
            new_following = Traveller.objects.get(username__username=username)
            user = Traveller.objects.get(username = request.user)
            # add following to currect user
            following =TravellerFollowing(
                    traveller_id = user,
                    following_traveller_id = new_following
                )
            following.save()
            return Response(status=status.HTTP_202_ACCEPTED)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class UnfollowView(APIView):
    def get(self, request, username):
        try:
            new_following = Traveller.objects.get(username__username=username)
            user = Traveller.objects.get(username = request.user)
            # add following to currect user
            following =TravellerFollowing.objects.get(
                    traveller_id = user,
                    following_traveller_id = new_following
                )
            following.delete()
            return Response(status=status.HTTP_202_ACCEPTED)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


def get_object(request):
    try:
        user = request.user
        return get_object_or_404(Traveller, username=user)
        #return Traveller.objects.get(username=user)
    except Traveller.DoesNotExist:
        return Response(status=status.HTTP_400_BAD_REQUEST)
