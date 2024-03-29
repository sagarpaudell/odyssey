import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Search with ChangeNotifier {
  final String username;
  final String authToken;

  Search([this.username, this.authToken]);

  Future<List<dynamic>> search(String searchText, bool searchPlace) async {
    String url;
    if (searchPlace) {
      url =
          'https://travellum.herokuapp.com/places-api/search?place=$searchText';
    } else {
      url =
          'https://travellum.herokuapp.com/traveller-api/search?traveller=$searchText';
    }
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
