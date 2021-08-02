from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from django.contrib.auth.models import User
from django.db.models import Q

from traveller_api.models import Traveller
from .models import Chat
from .serializers import ChatSerializer

class ChatView(APIView):
    def get(self, request, username):
        """ returns the message of the authenticated user with username"""
        friend_user = Traveller.objects.get(username__username = username)
        login_user = Traveller.objects.get(username = self.request.user)
        chat = Chat.objects.filter(
                Q(sender = login_user) | Q(receiver=login_user),
                Q(receiver = friend_user) | Q(sender = friend_user)
            ).order_by('-message_time')
        if chat:
            if chat.first().sender == friend_user:
                chat.update(message_seen = True)
            serializer = ChatSerializer(
                    chat,
                    many=True
                )
            return Response(serializer.data)
        return Response(status = status.HTTP_404_NOT_FOUND)

    def post(self, request, username):
        """ receives post request in format {"message":""} and add new mesage
        to the database"""
        friend_user = Traveller.objects.get(username__username = username)
        login_user = Traveller.objects.get(username = self.request.user)
        message_text = request.data["message_text"]
        chat = Chat.objects.create(sender = login_user, receiver = friend_user,
                message_text = message_text)
        return Response(ChatSerializer(chat).data)

    def delete(self, request, username):
        """ deletes messages with username """
        friend_user = Traveller.objects.get(username__username = username)
        login_user = Traveller.objects.get(username = self.request.user)
        chat = Chat.objects.filter(
                Q(sender = login_user) | Q(receiver=login_user),
                Q(receiver = friend_user) | Q(sender = friend_user)
            ).order_by('-message_time')
        if chat:
            chat.delete()
            return Response(
                    {
                        'success' : True,
                        'success_msg' : 'chat deleted'
                    }
                )
        return Response(
                {
                    'error' : True,
                    'error_msg': "No chat found"
                },
                status = status.HTTP_404_NOT_FOUND
            )

class AllConversationsView(APIView):
    def get(self, request):
        """ returns the message of the authenticated user with username"""
        login_user = Traveller.objects.get(username = self.request.user)
        all_chat = Chat.objects.filter(
                Q(sender = login_user) | Q(receiver=login_user),
            )

        friends_set = set()
        for chat in all_chat:
            friend = chat.sender if chat.receiver == login_user else chat.receiver
            friends_set.add(friend)

        chat_list = list()
        for friend in friends_set:
            last_message = all_chat.filter(
                    Q(sender=friend) | Q(receiver=friend)
                ).last()
            chat_list.append(last_message)
        chat_list = sorted(chat_list, key=lambda x: x.message_time.isoformat())
        chat = ChatSerializer(chat_list, many=True)
        return Response(chat.data)
