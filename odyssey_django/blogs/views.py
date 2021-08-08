from django.db.models import Q
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import BlogSerializer,BlogCommentSerializer
from .models import Blog,BlogComment, Blog_notification
from notification.models import Notification, Notification_type
from traveller_api.models import Traveller
from places_api.models import Place

class MyBlogs(APIView):
    def get(self,request):
        user = Traveller.objects.get(username = self.request.user)
        blogs = Blog.objects.filter(author = user)
        serializer = BlogSerializer(
                blogs,
                context = {"traveller":user},
                many = True
            )
        return Response(serializer.data)

class NewsfeedBlogs(APIView):
    def get(self, request):
        traveller = Traveller.objects.get(username = request.user)
        following = traveller.get_following()
        blogs = Blog.objects.filter(Q(author__in = following) | Q(author = traveller))
        blog_serialized = BlogSerializer(blogs, many=True, context={"traveller": traveller})
        return Response(blog_serialized.data)       

class ViewBlogs(APIView):
    def get(self,request):
        user = Traveller.objects.get(username = self.request.user)
        blogs = Blog.objects.filter(public_post = True)
        serializer = BlogSerializer(
                blogs,
                context = {"traveller":user},
                many = True
            )
        return Response(serializer.data)

class BlogDetail(APIView):
    def get_object(self, id):
        try:
            return Blog.objects.get(id=id)
        except Blog.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):
        blog = self.get_object(id)
        user = Traveller.objects.get(username=request.user)
        serializer = BlogSerializer(blog, context = {"traveller":user})
        return Response(serializer.data)

    def put(self, request , id):
        blog = self.get_object(id)
        current_user = Traveller.objects.get(username = request.user)
        if current_user==blog.author:
            place = Place.objects.get(id = request.data["place"])
            blog.place = place
            blog.save()
            serializer = BlogSerializer(
                    blog,
                    data=request.data,
                    context = {"traveller":current_user}
                )
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        blog = self.get_object(id)
        current_user = Traveller.objects.get(username = request.user)
        if (current_user==blog.author):
            blog.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response(status=status.HTTP_400_BAD_REQUEST)

class AddBlog(APIView):
    def post(self, request):
        user = Traveller.objects.get(username = self.request.user)
        place = Place.objects.get(id = request.data["place"])      #send place id in API request
        title = request.data["title"]
        description = request.data["description"]
        photo1 = request.data["photo1"]
        photo2 = request.data["photo2"]
        photo3 = request.data["photo3"]
        photo4 = request.data["photo4"]
        blog = Blog.objects.create(title=title, author=user, place=place, description=description, photo1=photo1, photo2=photo2, photo3=photo3, photo4=photo4)
        return Response(BlogSerializer(blog).data)

class BlogLikeView(APIView):
    def put(self, request, id):
        blog = Blog.objects.get(id=id)
        if not blog:
            return Response(
                    {
                        "error": True,
                        "error_msg": "Blog not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        traveller = Traveller.objects.get(username=request.user)
        if traveller in blog.like_users.all():
            blog.like_users.remove(traveller)
            notification(traveller=traveller, blog=blog, remove=True)
            message = "Unliked blog"
        else:
            blog.like_users.add(traveller)
            notification(traveller=traveller, blog=blog)
            message = "Liked blog"
        blog.save()
        return Response({"success":message}, status = status.HTTP_200_OK)

# class ViewBlogComment(APIView):                 #view all the comments of a blog
#     def get(self, request, id):
#         blog = Blog.objects.get(id = id)
#         blog_comments = BlogComment.objects.filter(blog = blog)
#         serializer = BlogCommentSerializer(blog_comments, many = True)
#         return Response(serializer.data)

class BlogCommentDetail(APIView):               
    def get_object(self, id):
        try:
            return BlogComment.objects.get(id=id)
        except BlogComment.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):
        blog_comment = self.get_object(id)
        serializer = BlogCommentSerializer(blog_comment)
        return Response(serializer.data)

    def put(self, request , id):
        blog_comment = self.get_object(id)
        current_user = Traveller.objects.get(username = request.user)
        if (current_user == blog_comment.user):
            serializer = BlogCommentSerializer(blog_comment, data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        blog_comment = self.get_object(id)
        current_user = Traveller.objects.get(username = request.user)
        if (current_user == blog_comment.user):
            blog_comment.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST)


class AddBlogComment(APIView):
    def post(self, request, id):
        user = Traveller.objects.get(username = self.request.user)
        blog = Blog.objects.get(id = id)     #send blog id in API request
        comment = request.data["comment"]
        blog_comment = BlogComment.objects.create(blog=blog, user=user, comment=comment)
        return Response(BlogCommentSerializer(blog_comment).data)


class BookMarkView(APIView):
    def put(self, request, id):
        traveller_self = Traveller.objects.get(username = request.user)
        blog = get_blog(id)
        if not blog:
            return Response( {
                    "error": True,
                    "error_msg": "Blog not found"
                },
                status=status.HTTP_404_NOT_FOUND
            )
        if blog in traveller_self.bookmarked_blogs.all():
            blog.bookmark_users.remove(traveller_self)
            blog.save()
            message = "bookmark removed"
        else:
            blog.bookmark_users.add(traveller_self)
            blog.save()
            message = "blog bookmarked"
        return Response(
                    { "success": message },
                    status = status.HTTP_200_OK
                )



class BookMarkBlogView(APIView):
    def get(self, request):
        traveller_self = Traveller.objects.get(username = request.user)
        bm_blog = traveller_self.bookmarked_blogs.all()
        print(bm_blog)
        serializer = BlogSerializer(bm_blog, many=True,
                context = {"traveller":traveller_self}
                )
        return Response(serializer.data,status=status.HTTP_200_OK)

def get_blog(id):
    try:
        blog = Blog.objects.get(id = id)
    except Blog.DoesNotExist:
        return False
    return blog

def notification(blog=None, comment=None, traveller = None, remove = False):
    is_comment = bool(comment)
    is_like = not is_comment
    blog_notification, _created = Blog_notification.objects.get_or_create(
                        blog_id = blog,
                        is_like = is_like,
                        is_comment = is_comment,
                        comment_id = comment
                    )
    noti_type, _created = Notification_type.objects.get_or_create(
                        category = "BLOG",
                        blog_noti = blog_notification
                    )

    notification, _create = Notification.objects.get_or_create(
                sender = traveller,
                receipent = blog.author,
                noti_type = noti_type
            )
    if remove:
        return notification.noti_type.blog_noti.delete()
    return notification

