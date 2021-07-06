from django.db import models
from django.db.models.deletion import CASCADE
from django.db.models.fields.related import ForeignKey
from traveller_api.models import Traveller
from places_api.models import Place

class Blog(models.Model):
    title = models.CharField(max_length=200)
    author = models.OneToOneField(Traveller, on_delete= models.CASCADE, blank=True)
    place = models.ForeignKey(Place, on_delete=models.DO_NOTHING, blank=True)
    description = models.TextField(blank=True)
    photo1 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo2 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo3 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo4 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    date = models.DateTimeField(auto_now_add=True)
    like_users = models.ManyToManyField(Traveller, related_name='likedblog', blank=True)

    
    def __str__(self):
        return self.title

class BlogComment(models.Model):
    blog = models.ForeignKey(Traveller, on_delete = models.CASCADE, related_name='comments')
    user = models.ForeignKey(Traveller, on_delete = models.CASCADE, related_name='comments')
    comment = models.TextField()
    liked_users = models.ManyToManyField(Traveller, related_name='likedcomments')
    disliked_users = models.ManyToManyField(Traveller, related_name='dislikedcomments')
    comment_time = models.DateTimeField(auto_now_add=True)