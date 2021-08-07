from django.urls import path, include
from .views import (
        NotificationView, NotificationMarkAsRead, NotificationReadView,
        CheckNotification
        )

urlpatterns = [
        path('', NotificationView.as_view()),
        path('read-all', NotificationMarkAsRead.as_view()),
        path('get-new', CheckNotification.as_view()),
        path('<id>', NotificationReadView.as_view()),
]
