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
        post_serialized = PostSerializer(
                posts, many=True, context={"traveller":traveller}
            )
        return Response(post_serialized.data)


class Explore(APIView):
    def get(self):
        posts = Post.objects.filter(public_post=True)
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data, status = status.HTTP_200_OK)

class SelfPostView(APIView):
    parser_classes = [MultiPartParser]
    def post(self, request):
        traveller = Traveller.objects.get(username = self.request.user)
        request.data._mutable = True
        place_id = request.data.pop("place_id", False)
        request.data._mutable = False
        serializer = PostSerializer(data=request.data)
        if place_id:
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
            serializer = PostSerializer(
                    data = request.data,
                    context={"traveller":traveller}
                )

        if serializer.is_valid(raise_exception=ValueError):
            if place_id:
                serializer.save(place=place, traveller=traveller)
            else:
                serializer.save(traveller=traveller)

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
        traveller = Traveller.objects.get(username = request.user)
        posts = traveller.posts.all()
        print(posts)
        serializer = PostSerializer(posts, many=True, context={"traveller":traveller})
        return Response(serializer.data)


class PostView(APIView):
    def get(self, request, id):
        post = get_post(id)
        if not post:
            return Response(status=status.HTTP_404_NOT_FOUND)
        traveller = Traveller.objects.get(username=request.user)
        following = traveller.get_following()
        if post.traveller in following or post.traveller.username == request.user:
            serializer = PostSerializer(post, context= {"traveller": traveller})
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    def put(self, request, id):
        post = get_post(id)
        if not post:
            return Response(status=status.HTTP_404_NOT_FOUND)
        if post.traveller == Traveller.objects.get(username = request.user):
            serializer = PostSerializer(post, data=request.data,)
            request.data._mutable = True
            place_id = request.data.pop("place_id", False)
            request.data._mutable = False
            if place_id:
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
            if serializer.is_valid(raise_exception = ValueError):
                if place_id:
                    serializer.save(place=place )
                else:
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

    def delete(self, request, id):
        post = get_post(id)
        if not post:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Post not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        if post.traveller == Traveller.objects.get(username = request.user):
            post.delete()
            return Response({"success":"post deleted"},
                    status = status.HTTP_200_OK
                )
        return Response(
                {
                    "error": True,
                    "error_msg": "Not your post"
                },
                status = status.HTTP_401_UNAUTHORIZED
            )


class LikeView(APIView):
    def put(self, request, id):
        post = get_post(id)
        if not post:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Post not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        traveller = Traveller.objects.get(username=request.user)
        if traveller in post.like_users.all():
            post.like_users.remove(traveller)
            message = "Unliked post"
        else:
            post.like_users.add(traveller)
            message = "Liked post"
        traveller.save()
        return Response({"success":message}, status = status.HTTP_200_OK)

class CommentView(APIView):
    def post(self, request, id):
        """ here id is post id """
        post = get_post(id)
        if not post:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Post not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        traveller = Traveller.objects.get(username=request.user)
        serializer = CommentSerializer(data = request.data)
        if serializer.is_valid(raise_exception = ValueError):
            serializer.save(post_id=post, traveller=traveller)
            return Response(serializer.data, status = status.HTTP_200_OK)
        return Response(
               {
                   "error":True,
                   "error_msg": serializer.error_messages,
               },
               status=status.HTTP_400_BAD_REQUEST
               )

    def put(self, request, id):
        """ here id is comment id """
        try:
            comment = Comment.objects.get(id=id)
        except Comment.DoesNotExist:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Comment not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        if comment.traveller == Traveller.objects.get(username = request.user):
            serializer = CommentSerializer(comment, request.data)
        else:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Not commented by you"
                    },
                    status = status.HTTP_401_UNAUTHORIZED
                )

        if serializer.is_valid(raise_exception = ValueError):
            serializer.save()
            return Response(serializer.data, status = status.HTTP_200_OK)
        return Response(
               {
                   "error":True,
                   "error_msg": serializer.error_messages,
               },
               status=status.HTTP_400_BAD_REQUEST
           )

    def delete(self, request, id):
        try:
            comment = Comment.objects.get(id=id)
        except Comment.DoesNotExist:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Comment not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        if comment.traveller == Traveller.objects.get(username = request.user):
            comment.delete()
            return Response({"success":"comment deleted"},
                    status = status.HTTP_200_OK
                )
        return Response(
                {
                    "error": True,
                    "error_msg": "Not commented by you"
                },
                status = status.HTTP_401_UNAUTHORIZED
            )

class BookMarkView(APIView):
    def put(self, request, id):
        traveller_self = Traveller.objects.get(username = request.user)
        post = get_post(id)
        if not post:
            return Response( {
                    "error": True,
                    "error_msg": "Blog not found"
                },
                status=status.HTTP_404_NOT_FOUND
            )
        if post in traveller_self.bookmarked_posts.all():
            post.bookmark_users.remove(traveller_self)
            post.save()
            message="bookmark removed"
        else:
            post.bookmark_users.add(traveller_self)
            post.save()
            message = "bookmark added"
        return Response(
                { "success": message },
                status = status.HTTP_200_OK
                )

class BookMarkPostView(APIView):
    def get(self, request):
        traveller_self = Traveller.objects.get(username = request.user)
        bm_post = traveller_self.bookmarked_posts.all()
        serializer = PostSerializer(
                bm_post,
                many=True,
                context={"traveller": traveller_self}
            )
        return Response(
                serializer.data,
                status=status.HTTP_200_OK
            )

def get_post(id):
    try:
        post = Post.objects.get(id = id)
    except Post.DoesNotExist:
        return False
    return post
