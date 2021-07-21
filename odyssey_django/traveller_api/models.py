from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save

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
