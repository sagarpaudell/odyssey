# Generated by Django 3.2.4 on 2021-08-06 15:58

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('post', '0006_post_notification'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post_notification',
            name='comment_id',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='post.comment'),
        ),
    ]
