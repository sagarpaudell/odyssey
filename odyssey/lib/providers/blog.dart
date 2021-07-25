import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Blog with ChangeNotifier {
  final String userId;
  final String username;
  // String friendUserName;
  final String authToken;
  List<dynamic> blogsData;

  Blog([this.username, this.userId, this.authToken]);

  Future<List<dynamic>> getAllBlogs() async {
    final _url = 'https://travellum.herokuapp.com/blogs-api';
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      blogsData = json.decode(response.body);

      return blogsData;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> getBlogById(String id) async {
    final _url = 'https://travellum.herokuapp.com/blogs-api/$id';
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      return json.decode(response.body);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
