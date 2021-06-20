from django.db import models
from datetime import datetime
from django.contrib.auth.models import User

class Place(models.Model):
    name = models.CharField(max_length=200,blank=True)
    city = models.CharField(max_length=100,blank=True)
    country = models.CharField(max_length=100,blank=True)
    photo_1 = models.ImageField(upload_to='photos/%Y/%m/%d/', blank=True)
    photo_2 = models.ImageField(upload_to='photos/%Y/%m/%d/', blank=True)
    photo_3 = models.ImageField(upload_to='photos/%Y/%m/%d/', blank=True)
    photo_4 = models.ImageField(upload_to='photos/%Y/%m/%d/', blank=True)
    description = models.TextField(blank=True)

    def __str__(self):
        return self.name

class Major_Attraction(models.Model):
    place = models.ForeignKey(Place, on_delete= models.CASCADE, blank=True)
    attraction_name = models.CharField(max_length=100,blank=True)
    description = models.TextField(blank=True)
    thing_to_do = models.BooleanField(blank=True)
    place_to_visit = models.BooleanField(blank=True)