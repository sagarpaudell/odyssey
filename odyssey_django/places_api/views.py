from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,generics
from .serializers import MajorAttractionSerializer, PlaceSerializer
from .models import Place,Major_Attraction

class PlaceView(APIView):
    def get_object(self, id):
        try:
            return Place.objects.get(id=id)
        except Place.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, id):
        place = self.get_object(id)
        serializer = PlaceSerializer(place)
        return Response(serializer.data)

    def put(self, request , id):
        place = self.get_object(id)
        print(request.data)
        serializer = PlaceSerializer(place, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        place = self.get_object(id)
        place.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class MajorAttractionView(generics.ListCreateAPIView):
    serializer_class = MajorAttractionSerializer
    def get_object(self, id):
        try:
            place = Place.objects.get(id=id)
            return Major_Attraction.objects.filter(place = place)
        except Place.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def get(self, request, id):
        major_attractions = self.get_object(id)
        serializer = MajorAttractionSerializer(major_attractions, many = True)
        print (serializer.data)
        return Response(serializer.data)

    # def put(self, request , id):
    #     major_attractions = self.get_object(id)
    #     print(request.data)
    #     serializer = MajorAttractionSerializer(major_attractions, data=request.data)
    #     if serializer.is_valid():
    #         serializer.save()
    #         return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
    #     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # def delete(self, request, id):
    #     place = self.get_object(id)
    #     major_attractions = Major_Attraction.objects.get(place=place)
    #     major_attractions.delete()
    #     return Response(status=status.HTTP_204_NO_CONTENT)
