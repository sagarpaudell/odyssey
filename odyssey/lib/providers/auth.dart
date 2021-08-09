import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String token;
  String _rootToken;
  String userName;
  String fullName;
  String userId;
  // bool dataPersisted;
  bool email_verifed = false;
  Map<String, dynamic> userProfileInfo;
  DateTime _expiryDate;
  String _userRefreshToken;
  bool get isAuth {
    return token != null;
  }

  Future<bool> checkDataPersist() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('refreshToken')) {
      print('data is not in device');

      return false;
    }

    return true;
  }

  Future<void> getToken(
      {String username = 'postgres',
      String password = 'postgres',
      bool rememberMe}) async {
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

      if (json.decode(response.statusCode.toString()) == 401) {
        throw HttpException('Invalid Username or Password');
      }
      if (username == 'postgres') {
        _rootToken = json.decode(response.body)['access'];
      } else {
        token = json.decode(response.body)['access'];
        _userRefreshToken = json.decode(response.body)['refresh'];
        if (rememberMe) {
          print('true rem me');
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('refreshToken', _userRefreshToken);
        }
      }
      await authenticate(token);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> authenticate(String token) async {
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

  Future<void> signup(
    String email,
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
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String username, String password, bool rememberMe) async {
    return getToken(
        username: username, password: password, rememberMe: rememberMe);
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

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('refreshToken')) {
      print('data is not in device');
      // dataPersisted = false;
      return false;
    }
    print('data is  in device');
    _userRefreshToken = prefs.getString('refreshToken');
    const url =
        'https://travellum.herokuapp.com/accounts-api/refresh-auth-token/'; //...
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "refresh": _userRefreshToken,
          },
        ),
      );
      Map<String, dynamic> respondeDatam = json.decode(response.body);

      if (respondeDatam.containsKey('code')) {
        return false;
      }
      token = respondeDatam['access'];
      // print('access $token');
      await authenticate(token);
      notifyListeners();
      return true;
    } catch (e) {
      throw e;
    }
    // token = extractedUserData['token'];

    // _expiryDate = expiryDate;
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

  Future<void> logout() async {
    token = null;
    userName = null;
    fullName = null;
    userId = null;
    userProfileInfo = null;
    // dataPersisted = false;
    _userRefreshToken = null;
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }
}
