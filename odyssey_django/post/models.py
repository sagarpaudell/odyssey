from django.db import models
from traveller_api.models import Traveller
from places_api.models import Place

# Create your models here.
class Post(models.Model):
    traveller = models.ForeignKey(Traveller, on_delete=models.CASCADE, related_name='posts')
    caption = models.TextField(blank = True, null = False)
    photo = models.ImageField(upload_to='post/%Y/%m/%d/', blank=True)
    place = models.ForeignKey(Place, on_delete=models.DO_NOTHING, related_name='posts')
    like_users = models.ManyToManyField(Traveller, related_name='likedposts', blank=True)
    post_time = models.DateTimeField(auto_now_add=True , blank=False)
    public_post = models.BooleanField(default=True, blank=False)

    # def likes_count(self):
        # return self.like_users.count()

    # def get_post_by(self):
        # return f'{self.Traveller.first_name} {self.Traveller.last_name}'

    # def get_time(self):
        # return self.post_time

    # def get_place(self):
        # return self.place.name

    # def gettraveller_id(self):
        # traveller = Traveller.objects.get(email=self.user)
        # return traveller.id

    def __str__(self):
        return f'{self.id} by {self.traveller.username.username}'



class Comment(models.Model):
    post_id=models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    traveller = models.ForeignKey(Traveller, on_delete=models.CASCADE,
            related_name='comments')
    comment = models.TextField(blank = False, null=False)
    comment_time = models.DateTimeField(auto_now_add=True, blank=True )
