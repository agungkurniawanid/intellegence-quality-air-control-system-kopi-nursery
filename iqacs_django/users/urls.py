# users/urls.py
from django.urls import path
from .views import RegisterView, LoginView
from django.http import JsonResponse

# Tambahkan view untuk API overview
def api_overview(request):
    return JsonResponse({"message": "Welcome to the API Overview!"})

urlpatterns = [
    path('', api_overview, name='api-overview'),
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
]
