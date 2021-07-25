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
}
