from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authtoken.models import Token

from .serializers import UserSerializer


class UserRecordView(APIView):
    """ API View to create or get user info.
    a POST request allows to create a new user.
    """
    def get(self, format=None):
        """make get request with token present in the authentication header
        to get user info"""
        token = self.request.headers["Authorization"].split(" ")[1]
        print(token)
        user = Token.objects.get(key=token).user
        print(user)
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def post(self, request):
        """make post request with user info to register"""
        serializer = UserSerializer(data = request.data)
        print(serializer)
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
