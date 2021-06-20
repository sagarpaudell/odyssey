# CHAT
## Chat with specific user 
send a get request to **https://travellum.herokuapp.com/chat-api/sagar/** where **sagar** is the username

You will recieve something like the following as the response. 
```
[
    {
        "sender": {
            "username": "biraj",
            "id": 8,
            "first_name": "Biraje",
            "last_name": "Adhikari",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": "/photos/2021/06/20/hijikata_k68mcmr.png"
        },
        "receiver": {
            "username": "sagar",
            "id": 11,
            "first_name": "Sagar",
            "last_name": "Paudell",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": null
        },
        "message_text": "sankeko bhai",
        "message_time": "Jun 20 2021 08:07:31:am",
        "message_seen": false
    },
    {
        "sender": {
            "username": "sagar",
            "id": 11,
            "first_name": "Sagar",
            "last_name": "Paudell",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": null
        },
        "receiver": {
            "username": "biraj",
            "id": 8,
            "first_name": "Biraje",
            "last_name": "Adhikari",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": "/photos/2021/06/20/hijikata_k68mcmr.png"
        },
        "message_text": "haina daju haina",
        "message_time": "Jun 20 2021 08:07:42:am",
        "message_seen": false
    }
]
```
Each entry in the above json list corresponds to a message sent in between 
the authenticated user and the username in the url path

## Sending message to a specific user
Same as getting the message but send post request instead with following as the body
```
{
    "message_text": "hey wanna go on a date??"
}

```

## Message overview page:
Send get request to **http://travellum.herokuapp.com/chat-api/**. You will get
something like the following as the response:
```
[
    {
        "sender": {
            "username": "sagar",
            "id": 11,
            "first_name": "Sagar",
            "last_name": "Paudell",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": null
        },
        "receiver": {
            "username": "biraj",
            "id": 8,
            "first_name": "Biraje",
            "last_name": "Adhikari",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": "/photos/2021/06/20/hijikata_k68mcmr.png"
        },
        "message_text": "haina daju haina",
        "message_time": "Jun 20 2021 08:07:42:am",
        "message_seen": false
    },
    {
        "sender": {
            "username": "biraj",
            "id": 8,
            "first_name": "Biraje",
            "last_name": "Adhikari",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": "/photos/2021/06/20/hijikata_k68mcmr.png"
        },
        "receiver": {
            "username": "samesh",
            "id": 9,
            "first_name": "Samesh",
            "last_name": "Bazracharya",
            "address": "",
            "city": "",
            "country": "",
            "bio": "",
            "contact_no": "",
            "gender": "",
            "photo_main": null
        },
        "message_text": "Fuck you samesh",
        "message_time": "Jun 20 2021 13:09:56:pm",
        "message_seen": false
    }
]
```
Each element of the above json array response, corresponds to the latest 
message in between the logged in user and all the people who has had a 
conversation with the loggen in user. Pardon my tate fate english. Hope you
got the gist


