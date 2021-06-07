import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;

  // Future<void> _authenticate(String email, String password) async {
  //   const url = ''; //...
  //   final response = await http.post(
  //     url,
  //     body: json.encode(
  //       {
  //         'email': email,
  //         'password': password,
  //       },
  //     ),
  //   );
  // }

  Future<void> signup(
      String email, String phone, String userName, String password) async {
    const _url = 'http://localhost:9000/accounts-api/user/';
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: <String, String>{
          'Authorization': 'TOKEN; 6afedf61ba291a48c0ecb54e793b7b83b0e79c0c'
        },
        body: json.encode(
          {
            'email': email,
            'phone': phone,
            'userName': userName,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url = 'https://localhost:8000/accounts-api/get-auth-token/ '; //...
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
