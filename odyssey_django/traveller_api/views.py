from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import TravellerSerializer
from .models import Traveller


class TravellerView(APIView):

    def get_object(self, id):
        try:
            return Traveller.objects.get(id=id)
        except Traveller.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, id):
        traveller = self.get_object(id)
        serializer = TravellerSerializer(traveller)
        return Response(serializer.data)

    def put(self, request , id):
        traveller = self.get_object(id)
        serializer = TravellerSerializer(traveller, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        traveller = self.get_object(id)
        traveller.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
