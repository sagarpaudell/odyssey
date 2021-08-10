from django.db.models import Q
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from traveller_api.models import Traveller
from .models import Notification
from .serializer import NotificationSerializer

class NotificationView(APIView):
    def get(self, request):
        traveller = Traveller.objects.get(username=request.user)
        notifications = traveller.received_notifications.all().filter(
                ~Q( sender = traveller)
            ).order_by('-time')
        notifications.update(is_new = False)
        serializer = NotificationSerializer(notifications, many = True)
        return Response(serializer.data)


class NotificationMarkAsRead(APIView):
    def put(self, request):
        traveller = Traveller.objects.get(username=request.user)
        notifications = traveller.received_notifications.all()
        notifications.update(is_new = False, is_read = True)
        return Response(
                {
                    "success": "true"
                },
                status = status.HTTP_200_OK
            )

class NotificationReadView(APIView):
    def put(self, request, id):
        try:
            notification = Notification.objects.get(id = id)
        except Notification.DoesNotExist:
            return Response(
                    {
                        "error": True,
                        "error_msg": "notification not found"
                    },
                    status=status.HTTP_404_NOT_FOUND
                )
        if notification.receipent.username == request.user:
            notification.is_read=True
            return Response(
                    {
                        "success": True
                    },
                        status = status.HTTP_200_OK
                )
        return Response( {
                    "error": True,
                    "error_msg": "Not your notification"
                },
                status=status.HTTP_401_UNAUTHORIZED
            )

class CheckNotification(APIView):
    def get(self, request):
        traveller = Traveller.objects.get(username=request.user)
        new_notifications = traveller.received_notifications.all().filter(
                is_new = True
            )
        count = new_notifications.count()
        serializer = NotificationSerializer(new_notifications, many = True)
        return Response(serializer.data)
