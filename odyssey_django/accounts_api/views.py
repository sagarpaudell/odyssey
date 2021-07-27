from rest_framework import response
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authtoken.models import Token
from .models import OTP
from .serializers import OTPSerializer, UserSerializer
from django.contrib.auth.models import User
from datetime import datetime, timezone
import random
from django.core.mail import send_mail
from django.conf import settings
from django.shortcuts import get_object_or_404

class UserRecordView(APIView):
    """ API View to create or get user info.
    a POST request allows to create a new user.
    """
    def get(self, format=None):
        """make get request with token present in the authentication header
        to get user info"""
        serializer = UserSerializer(self.request.user)
        return Response(serializer.data)

    def post(self, request):
        """make post request with user info to register"""
        request.data["username"] = request.data["username"].lower()
        request.data["first_name"] = request.data["first_name"].title()
        request.data["last_name"] = request.data["last_name"].title()
        serializer = UserSerializer(data = request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                    serializer.data,
                    status=status.HTTP_201_CREATED,
                )
        return Response(
               {
                   "error":True,
                   "error_msg": serializer.error_messages,
               },
               status=status.HTTP_400_BAD_REQUEST
               )

    def put(self, request):
        """make post request with user info to register"""
        user = self.request.user
        request.data["username"] = request.data["username"].lower()
        request.data["first_name"] = request.data["first_name"].title()
        request.data["last_name"] = request.data["last_name"].title()
        serializer = UserSerializer(user, data = request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.save(validated_data=request.data)
            return Response(
                    serializer.data,
                    status=status.HTTP_201_CREATED,
                )
        return Response(
               {
                   "error":True,
                   "error_msg": serializer.error_messages,
               },
               status=status.HTTP_400_BAD_REQUEST
               )

class OTPVerification(APIView):
    def post(self , request):
        username = request.data["username"].lower()
        user = User.objects.get(username = username)
        otp = OTP.objects.get(username=user)
        if (otp.verified_email == False):
            otp.date = datetime.now(timezone.utc)
            otp.otp = random.randint(100000,999999)
            otp.email_verification = True
            otp.password_reset = False
            otp.allow_reset = True
            otp.save()
            subject = 'Email Verification'
            message =  f'Please use this otp to verify your Email:{otp.otp}'
            email_from = 'odysseydmn@gmail.com'
            recipient_list = [str(user.email),]
            send_mail(subject, message, email_from, recipient_list)
            dict = {"otp_request":True}
        else:
            dict = {"otp_request":False}
        return Response(dict)

    def put(self , request):
        username = request.data["username"].lower()
        dict={}
        try:
            user = User.objects.get(username = username)
            otp = OTP.objects.get(username=user)
            otp.date = datetime.now(timezone.utc)
            otp.otp = random.randint(100000,999999)
            otp.email_verification = False
            otp.password_reset = True
            otp.save()
            subject = 'Password Reset OTP'
            message =  f'Please use this otp to reset password:{otp.otp}'
            email_from = 'odysseydmn@gmail.com'
            recipient_list = [str(user.email),]
            send_mail(subject, message, email_from, recipient_list)
            dict = {"otp_request":True, "email":user.email}
            return Response(dict)
        except:
            dict = {"otp_request":False}
            return Response(dict, status= status.HTTP_404_NOT_FOUND)

class CheckOTPPassword(APIView):
    def put(self, request):
        username = request.data["username"].lower()
        user = User.objects.get(username = username)
        otp = OTP.objects.get(username = user)
        user_entered_otp = request.data["OTP"]
        print(otp.time_difference())
        print(user_entered_otp)
        dict = {}
        if (str(otp.otp) == str(user_entered_otp) and otp.time_difference()<300 and otp.email_verification == False and otp.password_reset == True):
            otp.allow_reset = True
            otp.save()
            dict = {"allow_reset":True}
        else:
            otp.allow_reset = False
            otp.save()
            dict = {"allow_reset":False}
        return Response(dict) 
            
class ResetPassword(APIView):
    def put(self, request):
        username = request.data["username"].lower()
        user = User.objects.get(username = username)
        otp = OTP.objects.get(username = user)
        new_password = request.data["new_password"]
        dict = {}
        if (otp.time_difference()<300 and otp.allow_reset == True and otp.password_reset == True):
            user.set_password(new_password)
            user.save()
            otp.allow_reset = False
            otp.save()
            dict = {"password_reset":True}
        else:
            dict = {"password_reset":False}
        return Response (dict)

class VerifyEmail(APIView):
    def put(self, request):
        username = request.data["username"].lower()
        user = User.objects.get(username = username)
        otp = OTP.objects.get(username = user)
        user_entered_otp = request.data["OTP"]
        dict = {}
        if (str(otp.otp) == str(user_entered_otp) and otp.time_difference()<300 and otp.allow_reset == True and otp.email_verification == True):
            otp.verified_email = True
            otp.allow_reset = False
            otp.save()
            dict = {"email_verification":True}
        else:
            dict = {"email_verification":False}
        return Response (dict)

class CheckVerified(APIView):
    def get(self, request):
        user = User.objects.get(username=request.user)
        otp = get_object_or_404(OTP, username=user)
        otp_serializer = OTPSerializer(otp)
        return Response (otp_serializer.data)