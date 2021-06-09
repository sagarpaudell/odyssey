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

  bool get isAuth {
    return _token != null;
  }

  Future<void> getToken(
      {String username = 'postgres', String password = 'postgres'}) async {
    const url = 'http://10.0.2.2:8000/accounts-api/get-auth-token/'; //...
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
        _rootToken = json.decode(response.body)['token'];
        //print(json.decode(response.body));
      } else {
        _token = json.decode(response.body)['token'];
        const url = 'http://10.0.2.2:8000/accounts-api/user/'; //...

        final tokenHeader = 'TOKEN ' + _token;
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
    const _url = 'http://10.0.2.2:8000/accounts-api/user/';
    // getToken();
    // final authToken = ('TOKEN ' + _rootToken);
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'TOKEN b18930dd9cb5d1ba53e04138fd87e03fd962e0f1'
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
    // const url = 'http://10.0.2.2:8000/accounts-api/user/'; //...

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
