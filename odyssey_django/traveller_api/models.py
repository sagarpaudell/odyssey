from django.db import models
from django.contrib.auth.models import User
from datetime import datetime


class Traveller(models.Model):
    first_name = models.CharField(max_length=200,blank=True)
    last_name = models.CharField(max_length=200,blank=True)
    username = models.OneToOneField(User, on_delete= models.CASCADE, blank=True)
    address = models.CharField(max_length=200,blank=True)
    city = models.CharField(max_length=100,blank=True)
    country = models.CharField(max_length=100,blank=True)
    bio = models.TextField(blank=True)
    contact_no = models.CharField(max_length=20,blank=True)
    gender = models.CharField(max_length=10,blank=True)
    photo_main = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    reg_date = models.DateTimeField(auto_now_add=True)


    def __str__(self):
        return self.first_name