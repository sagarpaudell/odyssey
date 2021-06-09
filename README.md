# Odyssey

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# To call the authentication api endpoint
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
    "token": "6afedf61ba291a48c0ecb54e793b7b83b0e79c0c"
} 
```
## Register :
Send post request to **http://localhost:8000/accounts-api/user/** with following in the header:\
`Authorization : TOKEN 6afedf61ba291a48c0ecb54e793b7b83b0e79c0c`    
and  the folling as body in the json
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
To get user token send get request to **https://localhost:8000/accounts-api/get-auth-token/** 
with the following json as the body of the request
```
 {
    "username": "alisha231",
    "password": "heytheredelilah"
 }
```
This will give you the token for the user

Now if you send a get request to **https://localhost:8000/accounts-api/get-auth-token/** 
with the token as the authorization header. You will receive the information of the user from the database
