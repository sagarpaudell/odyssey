from django.urls import path
from rest_framework_simplejwt.views import (
        TokenObtainPairView,
        TokenRefreshView,
        )
from .views import CheckOTPPassword, CheckVerified, OTPVerification, ResetPassword, UserRecordView, VerifyEmail

app_name='accounts_api'
urlpatterns = [
        # make post request to user to register
        # make get request with 'Key token' in authorization header to get the user info
        path('user/', UserRecordView.as_view(), name='user'),
        # make post request to api-get-auth to get the token of the user
        path('get-auth-token/', TokenObtainPairView.as_view(), name='token_obtain'),
        path('refresh-auth-token/', TokenRefreshView.as_view(), name='token_refresh'),
        path('otpverification/',OTPVerification.as_view()),
        path('checkpasswordotp/',CheckOTPPassword.as_view()),
        path('resetpassword/',ResetPassword.as_view()),
        path('verifyemail/',VerifyEmail.as_view()),
        path('checkverified/',CheckVerified.as_view()),
    ]
