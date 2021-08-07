from django.db import models
from traveller_api.models import Traveller
from post.models import Post_notification, Post
from blogs.models import Blog_notification, Blog
from django.db.models.signals import pre_save
from django.dispatch import receiver


# Create your models here.
class Notification_type(models.Model):
    MONTH_CHOICES = (
        ("CHAT", "chat"),
        ("POST", "post"),
        ("BLOG", "blog"),
        ("FOLLOW", "follow"),
    )
    category = models.CharField(max_length = 7, choices = MONTH_CHOICES, blank = False)
    Blog_Noti = models.ForeignKey(
            Blog_notification, 
            on_delete = models.CASCADE,
            null = True
        )
    Post_Noti = models.ForeignKey(
            Post_notification,
            on_delete = models.CASCADE,
            null = True
        )

class Notification(models.Model):
    sender = models.ForeignKey(Traveller, on_delete = models.SET_NULL,
            related_name = "sent_notifications", null = True)
    receipent = models.ForeignKey(Traveller, on_delete = models.SET_NULL,
            related_name = "received_notifications", null = True)
    noti_type = models.ForeignKey(Notification_type, on_delete = models.CASCADE,
            related_name = "notification", null = False)
    time = models.DateTimeField(auto_now_add = True)
    is_new = models.BooleanField(default = True)
    is_read = models.BooleanField(default = False)



@receiver(pre_save, sender = Post)
def check_like(sender, instance, **kwargs):
    print(sender, instance)
    print(instance.like_users.all().count())
    print(Post.objects.get(id = instance.id).like_users.all().count())
    print(kwargs)
