import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;

  Future<void> _authenticate(String email, String password) async {
    const url = ''; //...
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
  }

  Future<void> signup(
      String email, String phone, String userName, String password) async {
    const url = ''; //...
    try {
      final response = await http.post(
        url,
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
    const url = ''; //...
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
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
}
