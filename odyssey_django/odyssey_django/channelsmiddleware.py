from urllib.parse import parse_qs

from channels.auth import AuthMiddlewareStack
from channels.db import database_sync_to_async

from django.contrib.auth.models import AnonymousUser
from django.conf import settings
from django.contrib.auth.models import User


from rest_framework_simplejwt.tokens import UntypedToken
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError

from jwt import decode as jwt_decode


@database_sync_to_async
def get_user(user_id):
    try:
        return User.objects.get(id=user_id)
    except User.DoesNotExist:
        return AnonymousUser()

class TokenAuthMiddleware:
    """
    Token authorization middleware for Django Channels 
    """

    def __init__(self, app):
        self.app = app

    async def __call__(self, scope, receive, send):
        # Close old database connections to prevent usage of timed out connections
        #Get token
        token = parse_qs(scope["query_string"].decode("utf8"))["token"][0]

        try:
            UntypedToken(token)
        except (InvalidToken, TokenError) as e:
            print(e)
            user = await get_user(0)
        else:
            decoded_data = jwt_decode(
                    token,
                    settings.SECRET_KEY,
                    algorithms=["HS256"]
                )
            user = await get_user(decoded_data["user_id"])
        scope['user'] = user
        return await self.app(scope, receive, send)



