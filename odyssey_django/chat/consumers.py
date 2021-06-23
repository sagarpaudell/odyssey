# chat/consumers.py
import json

from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async

from django.contrib.auth.models import User
from traveller_api.models import Traveller
from chat.models import Chat

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.traveller = await get_traveller(self.scope["user"].username)
        print(f"{self.traveller=}")
        self.friend_traveller = await get_traveller(
                self.scope["url_route"]["kwargs"]["friend"]
            )
        print(f"{self.friend_traveller.id=}")

        if self.friend_traveller.id > self.traveller.id:
            self.room_group_name = f'{self.friend_traveller.id}-{self.traveller.id}'
        else:
            self.room_group_name = f'{self.traveller.id}-{self.friend_traveller.id}'
        print(self.room_group_name)
        #join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        # accept connection
        await self.accept()

    async def disconnect(self, close_code):
        #leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message=text_data_json['message']
        print(message)
        #save message
        chat_time = await self.save_messages( message )
        #send message to room
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message,
                'sender' : self.scope["user"].username,
                'time'   : chat_time
            }
        )

    async def chat_message(self, event):
        """ Sends message to the corresponding client """
        await self.send(json.dumps(event))
        print(f'{event["sender"]}-> {self.scope["user"].username} text_data={event["message"]}')

    @database_sync_to_async
    def save_messages(self, message):
        sender = self.traveller
        receiver = self.friend_traveller
        chat = Chat.objects.create(
                sender = sender,
                receiver = receiver,
                message_text = message
            )
        return chat.message_time.isoformat()


@database_sync_to_async
def get_traveller(username):
    x = User.objects.get(username=username)
    traveller = Traveller.objects.get(username=x)
    return traveller

