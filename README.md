# JWT authentication
## Requesting the token
First send a post request to **https://localhost:8000/accounts-api/get-auth-token/** with following json as the body of the request:
```
{
    "username": "admin",
    "password": "asdfjkl;"
}
```

You will recieve something like the following as the response. 
```

{
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMzU2NDEyNywianRpIjoiZmI3MTA0YWQzYWIzNDAyZDkzNjk0YzczMjhiZGYwZWIiLCJ1c2VyX2lkIjo5fQ.Clr_d8CCKA6vq-31TcQjRlAr9Ks2TYnQdrgdTuha2mQ",
    "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjIzNDc4MDI3LCJqdGkiOiI4YzgwNDMwZGZhNzI0OGI5OGNlMmI4YTk5NmUyNGJjZCIsInVzZXJfaWQiOjl9.MS3PTh3RgCPE9zcfXSC3F4aCU_bR4rKhDWWi_pDB8eQ"
}
 
```
## Refresh token
When the short-lived access token expires, you can use the longer-lived refresh
token to obtain another access token by sending following json as the body of
the request to **http://localhost:8000/accounts-api/refresh-auth-token/**
```
{
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMzU2NDEyNywianRpIjoiZmI3MTA0YWQzYWIzNDAyZDkzNjk0YzczMjhiZGYwZWIiLCJ1c2VyX2lkIjo5fQ.Clr_d8CCKA6vq-31TcQjRlAr9Ks2TYnQdrgdTuha2mQ"
}
```



## Register :
Send post request to **http://localhost:8000/accounts-api/user/** with
following in the header:\ `Authorization : Bearer <access>`      
and  the following as body in the json
```
{
    "username": "alisha231",
    "first_name": "alisha",
    "last_name": "shrestha",
    "email": "alisha@shrestha.com",
    "password": "heytheredelilah"
}
```
##  Login:

if you send a get request to **http://localhost:8000/accounts-api/user/** with
authorization header with the users access token, you will receive the
information of the user from the database
