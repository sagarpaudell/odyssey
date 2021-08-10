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

  Future<List<dynamic>> getAllBlogs(bool explore) async {
    String _url;
    if (explore) {
      _url = 'https://travellum.herokuapp.com/blogs-api';
    } else {
      _url = 'https://travellum.herokuapp.com/blogs-api/feedblogs';
    }
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

  Future<List<dynamic>> getBookmarkedBlogs() async {
    final _url = 'https://travellum.herokuapp.com/blogs-api/bookmarked';
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

  Future<void> toogleBookmarkedBlog(String id) async {
    final url = 'https://travellum.herokuapp.com/blogs-api/bookmark/$id';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      print(json.decode(response.statusCode.toString()));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getBlogsByPlace(String id) async {
    final url = 'https://travellum.herokuapp.com/blogs-api/place/$id';

    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final blogData = json.decode(userDataResponse.body);
      notifyListeners();
      return blogData;
    } catch (e) {
      print(e);
    }
  }
}
