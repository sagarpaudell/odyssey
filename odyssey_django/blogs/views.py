from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import BlogSerializer,BlogCommentSerializer
from .models import Blog,BlogComment
from traveller_api.models import Traveller
from places_api.models import Place

class MyBlogs(APIView):
    def get(self,request):
            user = Traveller.objects.get(username = self.request.user)
            blogs = Blog.objects.filter(author = user)
            serializer = BlogSerializer(blogs, many = True)
            print (serializer)
            return Response(serializer.data)

class BlogDetail(APIView):
    def get_object(self, id):
        try:
            return Blog.objects.get(id=id)
        except Blog.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):
        blog = self.get_object(id)
        serializer = BlogSerializer(blog)
        return Response(serializer.data)

    def put(self, request , id):
        blog = self.get_object(id)
        place = Place.objects.get(id = request.data["place"])
        blog.place = place
        blog.save()
        serializer = BlogSerializer(blog, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        blog = self.get_object(id)
        blog.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

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
        blog = Blog.objects.create(title=title , author=user, place=place, description=description, photo1=photo1, photo2=photo2, photo3=photo3, photo4=photo4)
        return Response(BlogSerializer(blog).data)

class ViewBlogComment(APIView):                 #view all the comments of a blog
    def get(self, request, id):
        blog = Blog.objects.get(id = id)
        blog_comments = BlogComment.objects.filter(blog = blog)
        serializer = BlogCommentSerializer(blog_comments, many = True)
        return Response(serializer.data)

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
        serializer = BlogCommentSerializer(blog_comment, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        blog_comment = self.get_object(id)
        blog_comment.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class AddBlogComment(APIView):
    def post(self, request, id):
        user = Traveller.objects.get(username = self.request.user)
        blog = Blog.objects.get(id = id)     #send blog id in API request
        comment = request.data["comment"]
        blog_comment = BlogComment.objects.create(blog=blog, user=user, comment=comment)
        return Response(BlogCommentSerializer(blog_comment).data)