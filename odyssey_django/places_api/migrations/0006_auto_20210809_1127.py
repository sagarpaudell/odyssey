# Generated by Django 3.2.4 on 2021-08-09 11:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('places_api', '0005_auto_20210809_0841'),
    ]

    operations = [
        migrations.AlterField(
            model_name='place',
            name='city',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='place',
            name='country',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
