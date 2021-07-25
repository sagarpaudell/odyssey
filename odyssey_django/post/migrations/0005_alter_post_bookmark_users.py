# Generated by Django 3.2.4 on 2021-07-25 12:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('traveller_api', '0001_initial'),
        ('post', '0004_post_bookmark_users'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='bookmark_users',
            field=models.ManyToManyField(blank=True, related_name='bookmarked_posts', to='traveller_api.Traveller'),
        ),
    ]
