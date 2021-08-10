import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comments with ChangeNotifier {
  final String authToken;

  Comments([this.authToken]);

  Future<void> deleteComment(int id) async {
    final url = 'https://travellum.herokuapp.com/post-api/comment/$id';

    final token = 'Bearer ' + authToken;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      print(response.statusCode);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
