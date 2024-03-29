# Generated by Django 3.2.4 on 2021-08-09 07:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('traveller_api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Chat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('message_text', models.TextField(blank=True)),
                ('message_time', models.DateTimeField(auto_now_add=True)),
                ('message_seen', models.BooleanField(default=False)),
                ('message_seen_time', models.DateTimeField(auto_now_add=True)),
                ('receiver', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='receiver', to='traveller_api.traveller')),
                ('sender', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='sender', to='traveller_api.traveller')),
            ],
        ),
    ]
