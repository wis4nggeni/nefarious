# Generated by Django 3.0.2 on 2022-07-04 20:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('nefarious', '0070_nefarioussettings_enable_fake_video_detection'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='nefarioussettings',
            name='enable_fake_video_detection',
        ),
        migrations.AddField(
            model_name='nefarioussettings',
            name='enable_video_detection',
            field=models.BooleanField(default=True),
        ),
    ]