import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:odyssey/models/post.dart';

class Posts with ChangeNotifier {
  final String authToken;

  Posts([this.authToken]);
  Future<List<dynamic>> getSelfPosts() async {
    // print('getprofile');
    const url = 'https://travellum.herokuapp.com/post-api/post/';
    final token = 'Bearer ' + authToken;
    // print('token');
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final selfPostData = json.decode(userDataResponse.body);

      notifyListeners();
      return selfPostData;
    } catch (e) {
      print(json.decode(e));
      throw (e);
    }
  }

  // List<Map<String, dynamic>>
  Future<List<dynamic>> getPosts() async {
    const url = 'https://travellum.herokuapp.com/post-api/newsfeed';
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final postData = json.decode(userDataResponse.body);
      notifyListeners();
      return postData;
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getBookmarkedPosts() async {
    const url = 'https://travellum.herokuapp.com/post-api/bookmarked';
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final postBookmarkedData = json.decode(userDataResponse.body);
      notifyListeners();
      return postBookmarkedData;
    } catch (e) {
      print(e);
    }
  }

  Future<void> toogleBookmarkedPost(String id) async {
    final url = 'https://travellum.herokuapp.com/post-api/bookmark/$id';
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
}
