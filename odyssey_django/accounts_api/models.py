from django.db import models
from django.contrib.auth.models import User
from datetime import datetime, timezone
from django.db.models.signals import post_save
from pytz import utc


class OTP(models.Model):
    username = models.ForeignKey(User, on_delete= models.CASCADE)
    otp = models.IntegerField(blank=True, null=True)
    email_verification = models.BooleanField(default=True)
    password_reset = models.BooleanField(default=False)
    allow_reset = models.BooleanField(default = False)
    verified_email = models.BooleanField(default = False)
    date = models.DateTimeField(default = datetime.now(timezone.utc))

    def time_difference(self):
        x = self.date
        time_difference = datetime.now(timezone.utc)-x
        return(time_difference.total_seconds())

def edit_or_create_otp(sender, instance, **kwargs):
    otp = OTP.objects.filter(username=instance)
    if otp.exists():
        print ('otp exists')
    else:
        OTP.objects.create(username=instance)

post_save.connect(edit_or_create_otp, sender=User)