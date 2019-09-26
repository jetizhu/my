# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.
class Data(models.Model):
    server_name = models.CharField(max_length=200)
    server_port = models.IntegerField()
    backend_ip = models.TextField()
    backend_path = models.CharField(max_length=50)
