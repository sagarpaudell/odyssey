import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Place with ChangeNotifier {
  final String username;
  final String authToken;

  Place([this.username, this.authToken]);

  Future<List<dynamic>> getAllPlaces() async {
    final url = 'https://travellum.herokuapp.com/places-api';
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

  Future<Map<String, dynamic>> getSinglePlace(String id) async {
    final url = 'https://travellum.herokuapp.com/places-api/$id';
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
}
