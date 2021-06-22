# Generated by Django 3.2.4 on 2021-06-22 11:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('traveller_api', '0002_auto_20210622_1106'),
    ]

    operations = [
        migrations.AddField(
            model_name='traveller',
            name='followers',
            field=models.ManyToManyField(blank=True, related_name='_traveller_api_traveller_followers_+', to='traveller_api.Traveller'),
        ),
        migrations.AddField(
            model_name='traveller',
            name='following',
            field=models.ManyToManyField(blank=True, related_name='_traveller_api_traveller_following_+', to='traveller_api.Traveller'),
        ),
    ]
