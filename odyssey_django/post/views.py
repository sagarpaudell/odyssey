from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import MultiPartParser
from django.db.models import Q

from traveller_api.models import Traveller
from places_api.models import Place
from .serializers import PostSerializer, CommentSerializer
from .models import ( Post, Comment )


class NewsfeedView(APIView):
    def get(self, request):
        traveller = Traveller.objects.get(username = request.user)
        following = traveller.get_following()
        posts = Post.objects.filter(
                Q(traveller__in = following) | Q(traveller=traveller)
            ).order_by("-post_time")
        print(posts)
        post_serialized = PostSerializer(posts, many=True)
        return Response(post_serialized.data)

class SelfPostView(APIView):

    parser_classes = [MultiPartParser]

    def post(self, request):
        traveller = Traveller.objects.get(username = self.request.user)
        place_id= request.data.pop("place_id", False)
        try:
            place = Place.objects.get(id = place_id[0])
        except Place.DoesNotExist:
            return Response(
                    {
                        "error": True,
                        "error_msg": "invalid place id"
                    },
                    status=status.HTTP_404_NOT_FOUND
                    )
        serializer = PostSerializer(data = request.data)

        if serializer.is_valid(raise_exception=ValueError):
            # serailizer = serializer.create(
                    # validated_data=request.data,
                    # traveller=traveller,
                    # place = place
                # )
            serializer.save(place=place, traveller=traveller)
            print(serializer)
            return Response(
                    serializer.data,
                    status=status.HTTP_201_CREATED,
                )
        return Response(
               {
                   "error":True,
                   "error_msg": serializer.error_messages,
               },
               status=status.HTTP_400_BAD_REQUEST
               )

    def get(self, request):
        posts = Traveller.objects.get(username = request.user).posts.all()
        print(posts)
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data)


class PostView(APIView):
    def get(self, request, id):
        post = get_post(id)
        following = Traveller.objects.get(username=request.user).get_following()
        if post.traveller in following or post.traveller.username == request.user:
            serializer = PostSerializer(post)
            return Response(serializer.data)
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    def put(self, request, id):
        post = get_post(id)
        if post.traveller == Traveller.objects.get(username = request.user):
            serializer = PostSerializer(post, data=request.data)

            if serializer.is_valid(raise_exception = ValueError):
                serializer.save()
                return Response(serializer.data)

            return Response(
                   {
                       "error":True,
                       "error_msg": serializer.error_messages,
                   },
                   status=status.HTTP_400_BAD_REQUEST
                   )
        return Response(status=status.HTTP_401_UNAUTHORIZED)

def get_post(id):
    try:
        post = Post.objects.get(id = id)
    except post.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    return post

