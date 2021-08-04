from re import T
from io import BytesIO
from django.db import models
from django.core.files import File
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.core.files.storage import default_storage

from traveller_api.utils import image_resize
from cloudinary.models import CloudinaryField
class Traveller(models.Model):
    first_name = models.CharField(max_length=200,blank=True)
    last_name = models.CharField(max_length=200,blank=True)
    username = models.OneToOneField(User, on_delete= models.CASCADE)

    # followers = models.ManyToManyField('self', related_name="following", blank=True)
    # following = models.ManyToManyField('self', related_name="followers", blank=True)
    address = models.CharField(max_length=200,blank=True)
    city = models.CharField(max_length=100,blank=True)
    country = models.CharField(max_length=100,blank=True)
    bio = models.TextField(blank=True)
    contact_no = models.CharField(max_length=20,blank=True)
    gender = models.CharField(max_length=10,blank=True)
    photo_main = models.ImageField(upload_to='profile_photos/%Y/%m/%d/',blank=True)
    # photo_main = CloudinaryField('image', eager=[{'width': '50', 'height': '50', 'crop':'crop'}], transformation={'width': '100', 'height': '100', 'crop':'fill', 'radius':'20'}, folder='/profile_photos', format="jpeg",)
    reg_date = models.DateTimeField(auto_now_add=True)


    def __str__(self):
        id = self.id
        return f"{id=}, {self.username.username}"

    def get_following(self):
        following = [x.following_traveller_id for x in self.following.all()]
        return following

    def get_followers(self):
        follower = [x.traveller_id for x in self.followers.all()]
        return follower

    def get_username(self):
        return self.username.username

    def get_posts(self):
        return self.posts.all()

    def get_private_posts(self):
        return self.posts.filter(public_post = False)

    def get_public_posts(self):
        return self.posts.filter(public_post = True)

    def get_posts_count(self):
        return self.posts.all().count()

    def get_blogs(self):
        return self.blogs.all()

    def get_blogs_count(self):
        return self.blogs.all().count()

    # def save(self, *args, **kwargs):
        # if self.photo_main:
            # image_resize(self.photo_main, 400,400)
        # super().save(*args, **kwargs)


class TravellerFollowing(models.Model):
    traveller_id = models.ForeignKey(
            "Traveller",
            on_delete=models.CASCADE,
            related_name="following"
        )
    following_traveller_id = models.ForeignKey(
            "Traveller",
            on_delete=models.CASCADE,
            related_name="followers"
        )
    class Meta:
        unique_together = ('traveller_id', 'following_traveller_id',)


def edit_or_create_traveller(sender, instance, **kwargs):
    traveller = Traveller.objects.filter(username=instance)
    if traveller.exists():
        traveller = traveller.first()
        traveller.first_name = instance.first_name
        traveller.last_name = instance.last_name
        traveller.save()
    else:
        Traveller.objects.create(username=instance,
            first_name=instance.first_name,
            last_name=instance.last_name
            )

post_save.connect(edit_or_create_traveller, sender=User)
