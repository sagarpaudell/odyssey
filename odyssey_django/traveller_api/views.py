from django.shortcuts import render, get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import TravellerSerializer
from .models import Traveller
from django.contrib.auth.models import User
from rest_framework.parsers import MultiPartParser
from django.shortcuts import get_object_or_404

class TravellerView(APIView):
    parser_classes = [MultiPartParser]
    def get_object(self, request):
        try:
            user = request.user
            return get_object_or_404(Traveller, username=user)
            #return Traveller.objects.get(username=user)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def get(self, request):
        traveller = self.get_object(request)
        serializer = TravellerSerializer(traveller)
        return Response(serializer.data)

    def put(self, request):
        print(request.data)
        traveller = self.get_object(request)
        serializer = TravellerSerializer(traveller, data=request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request):
        traveller = self.get_object(request)
        traveller.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class FollowView(APIView):
    def get(self, request, username):
        try:
            new_following = Traveller.objects.get(username__username=username)
            user = Traveller.objects.get(username = request.user)
            user.following.add(new_following)
            user.save()
            return Response(status=status.HTTP_202_ACCEPTED)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
