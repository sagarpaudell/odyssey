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
  bool email_verifed = false;
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

      print(json.decode(response.statusCode.toString()));
      if (json.decode(response.statusCode.toString()) == 401) {
        //print(responseData);
        print('csdvs');
        throw HttpException('Invalid Username or Password');
      }
      if (username == 'postgres') {
        // print(json.decode(response.body));
        _rootToken = json.decode(response.body)['access'];
        // print(json.decode(response.body));
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
        const verifyUrl =
            'https://travellum.herokuapp.com/accounts-api/checkverified';
        try {
          final verifyResponse = await http.get(
            Uri.parse(verifyUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': tokenHeader
            },
          );
          email_verifed = json.decode(verifyResponse.body)['verified_email'];
          print('the email is $email_verifed');
        } catch (error) {
          //throw error;
          print('here is error');
        }
      }

      notifyListeners();
      final responseData = json.decode(response.body);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signup(
    String email,
    String phone,
    String userName,
    String password,
  ) async {
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

      print(json.decode(response.statusCode.toString()));
      // if (responseData['email']) {
      //   throw HttpException('email');
      // }
      // if (responseData['username'] != null) {
      //   throw HttpException('username');
      // }
    } catch (error) {
      print('blahhh');
      print(error);
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

  Future<Map<String, dynamic>> sendOTP(bool forForgotPass,
      [String uname]) async {
    var response;
    const otpUrl =
        'https://travellum.herokuapp.com/accounts-api/otpverification/';

    try {
      if (forForgotPass) {
        await getToken();
        response = await http.put(Uri.parse(otpUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_rootToken'
            },
            body: json.encode({
              'username': uname,
            }));
      } else {
        response = await http.post(Uri.parse(otpUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: json.encode({
              'username': userName,
            }));
      }
      final responseData = json.decode(response.body);

      return (responseData);
    } catch (error) {
      print(json.decode(error.body).toString());
      throw error;
    }
  }

  Future<bool> emailOTPVerify(String OTP) async {
    var response;
    const otpUrl = 'https://travellum.herokuapp.com/accounts-api/verifyemail/';

    try {
      response = await http.put(Uri.parse(otpUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'username': userName,
            'OTP': OTP,
          }));
      print(json.decode(response.body)['email_verification']);
      return json.decode(response.body)['email_verification'];
    } catch (error) {
      print(json.decode(error.body).toString());
      throw error;
    }
  }

  Future<bool> passwordOTPVerify(String OTP, String uname) async {
    getToken();
    var response;
    const otpUrl =
        'https://travellum.herokuapp.com/accounts-api/checkpasswordotp/';

    try {
      response = await http.put(Uri.parse(otpUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_rootToken'
          },
          body: json.encode({
            'username': uname,
            'OTP': OTP,
          }));
      print(json.decode(response.body)['allow_reset']);
      return json.decode(response.body)['allow_reset'];
    } catch (error) {
      print(json.decode(error.body).toString());
      throw error;
    }
  }

  Future<bool> passwordReset(String uname, String new_password) async {
    getToken();
    var response;
    const otpUrl =
        'https://travellum.herokuapp.com/accounts-api/resetpassword/';

    try {
      response = await http.put(Uri.parse(otpUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_rootToken'
          },
          body: json.encode({
            'username': uname,
            'new_password': new_password,
          }));
      print(
          '$uname has new pass $new_password with response ${json.decode(response.body)}');
      return json.decode(response.body)['password_reset'];
    } catch (error) {
      print(json.decode(error.body).toString());
      throw error;
    }
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
