# Generated by Django 3.2.4 on 2021-08-10 04:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('traveller_api', '0003_alter_traveller_photo_main'),
    ]

    operations = [
        migrations.AlterField(
            model_name='traveller',
            name='photo_main',
            field=models.ImageField(blank=True, default='man.svg', upload_to='profile_photos/%Y/%m/%d/'),
        ),
    ]
