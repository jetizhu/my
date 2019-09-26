from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter
from main import views

router = DefaultRouter()
router.register(r'api', views.DataViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]

