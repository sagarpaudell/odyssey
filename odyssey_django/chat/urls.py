from django.urls import path
from .views import (
        ChatView, AllConversationsView, CheckNewMessageView
    )

urlpatterns=[
        path('', AllConversationsView.as_view()),
        path('check-unread', CheckNewMessageView.as_view()),
        path('<str:username>',ChatView.as_view()),
]
