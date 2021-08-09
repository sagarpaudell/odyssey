# Generated by Django 3.2.4 on 2021-08-09 02:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('traveller_api', '0001_initial'),
        ('places_api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Blog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=200)),
                ('description', models.TextField(blank=True)),
                ('photo1', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo2', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo3', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo4', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('public_post', models.BooleanField(default=True)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('author', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='blogs', to='traveller_api.traveller')),
                ('bookmark_users', models.ManyToManyField(blank=True, related_name='bookmarked_blogs', to='traveller_api.Traveller')),
                ('like_users', models.ManyToManyField(blank=True, related_name='likedblog', to='traveller_api.Traveller')),
                ('place', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.DO_NOTHING, to='places_api.place')),
            ],
        ),
        migrations.CreateModel(
            name='BlogComment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comment', models.TextField()),
                ('comment_time', models.DateTimeField(auto_now_add=True)),
                ('blog', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comments', to='blogs.blog')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='traveller_api.traveller')),
            ],
        ),
        migrations.CreateModel(
            name='Blog_notification',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_like', models.BooleanField(blank=True, default=False)),
                ('is_comment', models.BooleanField(blank=True, default=False)),
                ('blog_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='blogs.blog')),
                ('comment_id', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='blogs.blogcomment')),
            ],
        ),
    ]
