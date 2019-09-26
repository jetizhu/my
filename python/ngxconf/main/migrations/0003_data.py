# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2019-08-13 02:02
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('main', '0002_delete_ngxconf'),
    ]

    operations = [
        migrations.CreateModel(
            name='Data',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('server_name', models.CharField(max_length=200)),
                ('server_port', models.IntegerField()),
                ('backend_ip', models.TextField()),
                ('backend_path', models.CharField(max_length=50)),
            ],
        ),
    ]
