from django.db import models
from django.db.models.deletion import CASCADE
from django.db.models.fields.related import ForeignKey
from traveller_api.models import Traveller
from places_api.models import Place

class Blog(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(Traveller, on_delete= models.CASCADE, blank=True, related_name="blogs")
    place = models.ForeignKey(Place, on_delete=models.DO_NOTHING, blank=True)
    description = models.TextField(blank=True)
    photo1 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo2 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo3 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    photo4 = models.ImageField(upload_to='photos/%Y/%m/%d/',blank=True)
    public_post = models.BooleanField(default=True, blank=False)
    date = models.DateTimeField(auto_now_add=True)
    like_users = models.ManyToManyField(Traveller, related_name='likedblog', blank=True)
    bookmark_users = models.ManyToManyField(Traveller, related_name='bookmarked_blogs', blank=True)

    
    def __str__(self):
        return self.title

    def is_bookmarked(self, traveller):
        return bool(traveller in self.bookmark_users.all())

class BlogComment(models.Model):
    blog = models.ForeignKey(Blog, on_delete = models.CASCADE, related_name='comments')
    user = models.ForeignKey(Traveller, on_delete = models.CASCADE,)
    comment = models.TextField()
    comment_time = models.DateTimeField(auto_now_add=True)

class Blog_notification(models.Model):
    blog_id=models.ForeignKey(Blog, on_delete=models.CASCADE)
    is_like = models.BooleanField(default = False, blank = True)
    is_comment = models.BooleanField(default = False, blank = True)
    comment_id = models.ForeignKey(
            BlogComment,
            on_delete = models.CASCADE,
            null = True,
            blank = True,
        )
