import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comments with ChangeNotifier {
  final String authToken;

  Comments([this.authToken]);

  Future<void> postComment(String id, String comment) async {
    final url = 'https://travellum.herokuapp.com/post-api/comment/$id';

    final token = 'Bearer ' + authToken;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: json.encode(
          {
            "comment": comment,
          },
        ),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteComment(String id) async {
    final url = 'https://travellum.herokuapp.com/post-api/comment/$id';

    final token = 'Bearer ' + authToken;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
