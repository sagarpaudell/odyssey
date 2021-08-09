from django.db import models
from traveller_api.models import Traveller
from places_api.models import Place

# Create your models here.
class Post(models.Model):
    traveller = models.ForeignKey(Traveller, on_delete=models.CASCADE,
            related_name='posts')
    caption = models.TextField(blank = True, null = False)
    photo = models.ImageField(upload_to='post/%Y/%m/%d/', blank=True)
    place = models.ForeignKey(Place, on_delete=models.SET_NULL,
            related_name='posts', blank=True, null=True)
    like_users = models.ManyToManyField(Traveller,
            related_name='likedposts', blank=True)
    post_time = models.DateTimeField(auto_now_add=True , blank=False)
    public_post = models.BooleanField(default=True, blank=False)
    bookmark_users = models.ManyToManyField(Traveller,
            related_name='bookmarked_posts', blank=True)

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
        return f'post({self.id}) by {self.traveller.username.username}'

    def is_bookmarked(self, traveller):
        return bool(traveller in self.bookmark_users.all())


class Comment(models.Model):
    post_id=models.ForeignKey(Post, on_delete=models.CASCADE, 
            related_name='comments')
    traveller = models.ForeignKey(Traveller, on_delete=models.CASCADE,
            related_name='comments')
    comment = models.TextField(blank = False, null=False)
    comment_time = models.DateTimeField(auto_now_add=True, blank=True )

    def __str__(self):
        return f"comment({self.id}) by {self.traveller} in {self.post_id}"

class Post_notification(models.Model):
    post_id=models.ForeignKey(Post, on_delete=models.CASCADE)
    is_like = models.BooleanField(default = False, blank = True)
    is_comment = models.BooleanField(default = False, blank = True)
    comment_id = models.ForeignKey(
            Comment,
            on_delete = models.CASCADE,
            null = True,
            blank = True,

        )

