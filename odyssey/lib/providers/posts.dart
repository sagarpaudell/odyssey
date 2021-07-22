import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:odyssey/models/post.dart';

class Posts with ChangeNotifier {
  final String authToken;

  Posts([this.authToken]);

  // List<Map<String, dynamic>>
  Future<List<dynamic>> getPosts() async {
    // print('getprofile');
    const url = 'https://travellum.herokuapp.com/post-api/newsfeed';
    final token = 'Bearer ' + authToken;
    // print('token');
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final postData = json.decode(userDataResponse.body);
      // print(postData);
      notifyListeners();
      return postData;
    } catch (e) {
      print(e);
    }
  }
}
