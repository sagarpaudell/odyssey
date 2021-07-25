import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String token;
  String _rootToken;
  String userName;
  String fullName;
  String userId;
  Map<String, dynamic> userProfileInfo;
  DateTime _expiryDate;
  String _userRefreshToken;
  bool get isAuth {
    return token != null;
  }

  Future<void> getToken(
      {String username = 'postgres', String password = 'postgres'}) async {
    // const url = 'http://10.0.2.2:8000/accounts-api/get-auth-token/';
    const url =
        'https://travellum.herokuapp.com/accounts-api/get-auth-token/'; //...
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "username": username,
            "password": password,
          },
        ),
      );
      if (username == 'postgres') {
        // print(json.decode(response.body));
        _rootToken = json.decode(response.body)['access'];
        //print(json.decode(response.body));
      } else {
        token = json.decode(response.body)['access'];
        _userRefreshToken = json.decode(response.body)['refresh'];
        // const url = 'http://10.0.2.2:8000/accounts-api/user/'; //...

        final tokenHeader = 'Bearer ' + token;
        const profurl = 'https://travellum.herokuapp.com/traveller-api/';

        try {
          final userDataResponse = await http.get(
            Uri.parse(profurl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': tokenHeader
            },
          );
          final userData = json.decode(userDataResponse.body);
          userProfileInfo = userData;
          userName = userData['username'];
          fullName = '${userData['first_name ']} ${userData['last_name ']}';
          userId = userData['id'].toString();
        } catch (error) {
          throw error;
        }
        userName = username;
      }

      notifyListeners();
      final responseData = json.decode(response.body);

      if (responseData['non_field_errors'] != null) {
        //print(responseData);
        //print('csdvs');
        throw HttpException('Invalid Username or Password');
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signup(
      String email, String phone, String userName, String password) async {
    const _url = 'http://10.0.2.2:8000/accounts-api/user/';
    getToken();
    final authToken = 'Bearer ' + _rootToken;
    print(authToken);
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': authToken
        },
        body: json.encode(
          {
            'email': email,
            //'phone': phone,
            'username': userName,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      // if (responseData['email']) {
      //   throw HttpException('email');
      // }
      // if (responseData['username'] != null) {
      //   throw HttpException('username');
      // }
    } catch (error) {
      //print(error);
      throw error;
    }
  }

  Future<void> login(String username, String password) async {
    return getToken(username: username, password: password);
    // const url = 'https://travellum.herokuapp.com/accounts-api/user/'; //...

    // final tokenHeader = 'TOKEN ' + token;
    // try {
    //   final userDataResponse = await http.get(
    //     Uri.parse(url),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': tokenHeader
    //     },
    //   );
    //   final userData = json.decode(userDataResponse.body);
    //   userName = userData['username'];
    // } catch (error) {
    //   throw error;
    // }
  }

  void logout() {
    token = null;
    userName = null;
    fullName = null;
    userId = null;
    userProfileInfo = null;

    _userRefreshToken = null;

    notifyListeners();
  }
}
