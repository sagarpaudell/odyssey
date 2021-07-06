# Generated by Django 3.2.4 on 2021-06-28 07:54

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Traveller',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(blank=True, max_length=200)),
                ('last_name', models.CharField(blank=True, max_length=200)),
                ('address', models.CharField(blank=True, max_length=200)),
                ('city', models.CharField(blank=True, max_length=100)),
                ('country', models.CharField(blank=True, max_length=100)),
                ('bio', models.TextField(blank=True)),
                ('contact_no', models.CharField(blank=True, max_length=20)),
                ('gender', models.CharField(blank=True, max_length=10)),
                ('photo_main', models.ImageField(blank=True, upload_to='profile_photos/%Y/%m/%d/')),
                ('reg_date', models.DateTimeField(auto_now_add=True)),
                ('username', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
