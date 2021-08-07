import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Notification with ChangeNotifier {
  final String username;
  final String authToken;

  Notification([this.username, this.authToken]);

  Future<List<dynamic>> getAllNotifications() async {
    final url = 'https://travellum.herokuapp.com/notification-api';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      notifyListeners();
      return json.decode(response.body);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<dynamic>> checkNewNotifications() async {
    final url = 'https://travellum.herokuapp.com/notification-api/get-new';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final resData = json.decode(response.body);
      if (resData != []) {
        notifyListeners();
      }
      return json.decode(response.body);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
