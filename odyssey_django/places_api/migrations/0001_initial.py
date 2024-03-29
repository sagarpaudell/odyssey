# Generated by Django 3.2.4 on 2021-08-09 02:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Place',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=200)),
                ('city', models.CharField(blank=True, max_length=100)),
                ('country', models.CharField(blank=True, max_length=100)),
                ('photo_1', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo_2', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo_3', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('photo_4', models.ImageField(blank=True, upload_to='photos/%Y/%m/%d/')),
                ('description', models.TextField(blank=True)),
            ],
        ),
        migrations.CreateModel(
            name='Major_Attraction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('attraction_name', models.CharField(blank=True, max_length=100)),
                ('description', models.TextField(blank=True)),
                ('thing_to_do', models.BooleanField(blank=True)),
                ('place_to_visit', models.BooleanField(blank=True)),
                ('place', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='places_api.place')),
            ],
        ),
    ]
