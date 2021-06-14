import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  String _rootToken;
  String userName;
  String _userId;
  DateTime _expiryDate;
  String _userRefreshToken;
  bool get isAuth {
    return _token != null;
  }

  Future<void> getToken(
      {String username = 'postgres', String password = 'postgres'}) async {
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
        _token = json.decode(response.body)['access'];
        _userRefreshToken = json.decode(response.body)['refresh'];
        const url = 'https://travellum.herokuapp.com/accounts-api/user/'; //...

        final tokenHeader = 'Bearer ' + _token;
        try {
          final userDataResponse = await http.get(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': tokenHeader
            },
          );
          final userData = json.decode(userDataResponse.body);
          userName = userData['username'];
          _userId = userData['id'];
        } catch (error) {
          throw error;
        }
      }

      notifyListeners();
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['non_field_errors'] != null) {
        //print(responseData);
        //print('csdvs');
        throw HttpException('Invalid Username or Password');
      }
    } catch (e) {
      print('object');
      print(e);
      throw (e);
    }
  }

  Future<void> signup(
      String email, String phone, String userName, String password) async {
    const _url = 'https://travellum.herokuapp.com/accounts-api/user/';
    getToken();
    final authToken = 'Bearer ' + _rootToken;
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

    // final tokenHeader = 'TOKEN ' + _token;
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
}
