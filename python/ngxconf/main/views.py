# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from rest_framework import viewsets
from main.serializers import DataSerializer
from main.models import Data
from django_filters import rest_framework as filters
from rest_framework.pagination import PageNumberPagination

class DataFilter(filters.FilterSet):
     class Meta:
          model = Data
          fields = [ 'server_name', 'server_port' ,'backend_ip', 'backend_ip' ]
class DataPagination(PageNumberPagination):
     page_size = 10
     page_size_query_param = 'page_size'
     page_query_param = 'page'
class DataViewSet(viewsets.ModelViewSet):
          queryset = Data.objects.all()
          serializer_class = DataSerializer
          pagination_class = DataPagination
          filter_backends = (filters.DjangoFilterBackend,)
          filter_class = DataFilter
# Create your views here.
