from django.db import models
from traveller_api.models import Traveller

class Chat(models.Model):
    sender=models.ForeignKey(Traveller, on_delete=models.SET_NULL,
            related_name="sender", null = True)
    receiver=models.ForeignKey(Traveller, on_delete=models.SET_NULL,
            related_name="receiver", null = True)
    message_text=models.TextField(blank=True)
    message_time = models.DateTimeField(auto_now_add = True)
    message_seen = models.BooleanField(default=False)
    message_seen_time = models.DateTimeField(auto_now_add = True)

    def get_time(self):
        return self.message_time.strftime("%b %d %Y %H:%M:%S:%P")
    
