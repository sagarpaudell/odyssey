# Generated by Django 3.2.4 on 2021-08-09 11:10

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('accounts_api', '0002_alter_otp_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='otp',
            name='date',
            field=models.DateTimeField(default=datetime.datetime(2021, 8, 9, 11, 10, 27, 769119, tzinfo=utc)),
        ),
    ]