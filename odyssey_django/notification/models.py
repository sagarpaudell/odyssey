from django.db import models
from traveller_api.models import Traveller
from post.models import Post_notification
from blogs.models import Blog_notification


# Create your models here.
class Notification_type(models.Model):
    NOTIFICATION_CHOICES = (
        ("POST", "post"),
        ("BLOG", "blog"),
        ("FOLLOW", "follow"),
    )
    category = models.CharField(max_length = 7, choices = NOTIFICATION_CHOICES,
            blank = False)
    blog_noti = models.OneToOneField(
            Blog_notification,
            on_delete = models.CASCADE,
            null = True,
            blank = True,
        )
    post_noti = models.OneToOneField(
            Post_notification,
            on_delete = models.CASCADE,
            null = True,
            blank = True,
        )

    def __str__(self):
        if self.post_noti:
            if self.post_noti.is_like:
                return f"like in {self.post_noti.post_id}"
            return f"{self.post_noti.comment_id}"
        if self.blog_noti:
            if self.blog_noti.is_like:
                return f"like in {self.blog_noti.blog_id}"
            return f"{self.blog_noti.comment_id}"
        return "follow"


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
