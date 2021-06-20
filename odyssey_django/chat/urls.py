from django.urls import path
from .views import ChatView
from .views import AllConversationsView

urlpatterns=[
        path('<str:username>',ChatView.as_view()),
        path('', AllConversationsView.as_view())
    # path('room/<int:course_id>/', chatView.course_chat_room, name='course_chat_room'),
]
