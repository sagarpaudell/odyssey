# Generated by Django 3.2.4 on 2021-08-08 07:14

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blogs', '0006_blog_public_post'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='blogcomment',
            name='disliked_users',
        ),
        migrations.RemoveField(
            model_name='blogcomment',
            name='liked_users',
        ),
    ]
