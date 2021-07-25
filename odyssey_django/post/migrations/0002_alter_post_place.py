# Generated by Django 3.2.4 on 2021-07-25 07:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places_api', '__first__'),
        ('post', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='place',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='posts', to='places_api.place'),
        ),
    ]
