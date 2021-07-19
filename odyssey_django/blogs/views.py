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
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, id):
        blog = self.get_object(id)
        serializer = BlogSerializer(blog)
        return Response(serializer.data)

    def put(self, request , id):
        blog = self.get_object(id)
        serializer = BlogSerializer(blog, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        place = self.get_object(id)
        place.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class AddBlog(APIView):
    def post(self, request):
        user = Traveller.objects.get(username = self.request.user)
        place = Place.objects.get(id = request.data["place"])
        title = request.data["title"]
        description = request.data["description"]
        photo1 = request.data["photo1"]
        photo2 = request.data["photo2"]
        photo3 = request.data["photo3"]
        photo4 = request.data["photo4"]
        blog = Blog.objects.create(title=title , author=user, place=place, description=description, photo1=photo1, photo2=photo2, photo3=photo3, photo4=photo4)
        return Response(BlogSerializer(blog).data)
