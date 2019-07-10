# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.
from django.db import models


class Category(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Colour(models.Model):
    name = models.CharField(max_length=100)
    category = models.ForeignKey(
        Category, related_name='colour', on_delete=models.CASCADE)

    def __str__(self):
        return self.name
