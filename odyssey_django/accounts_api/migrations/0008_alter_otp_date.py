# Generated by Django 3.2.4 on 2021-07-26 08:40

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('accounts_api', '0007_auto_20210726_0022'),
    ]

    operations = [
        migrations.AlterField(
            model_name='otp',
            name='date',
            field=models.DateTimeField(default=datetime.datetime(2021, 7, 26, 8, 40, 51, 312574, tzinfo=utc)),
        ),
    ]
