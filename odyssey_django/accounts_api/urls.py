from django.urls import path
from rest_framework.authtoken import views
from .views import UserRecordView

app_name='accounts_api'
urlpatterns = [
        # make post request to user to register
        # make get request with 'Key token' in authorization header to get the user info
        path('user/', UserRecordView.as_view(), name='user'),
        # make post request to api-get-auth to get the token of the user
        path('get-auth-token/', views.obtain_auth_token, name='api-token-auth'),
        path('get-auth-token/<int:pk>/',views.obtain_auth_token, name='api-token-auth'),
    ]
