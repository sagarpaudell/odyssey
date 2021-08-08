from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', include('pages.urls')),
    path('admin', admin.site.urls),
    path('accounts-api/', include('accounts_api.urls', namespace='api')),
    path('traveller-api/', include('traveller_api.urls')),
    path('places-api/', include('places_api.urls')),
    path('chat-api/', include('chat.urls')),
    path('post-api/', include('post.urls')),
    path('blogs-api/',include('blogs.urls')),
    path('notification-api/',include('notification.urls')),
]+ static(settings.MEDIA_URL, document_root= settings.MEDIA_ROOT)
