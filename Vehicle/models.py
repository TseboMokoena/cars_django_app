# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.
from django.db import models


class Colour(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Vehicle(models.Model):
    name = models.CharField(max_length=100)
    colour = models.ForeignKey(
        Colour, related_name='vehicle', on_delete=models.CASCADE)

    def __str__(self):
        return self.name
