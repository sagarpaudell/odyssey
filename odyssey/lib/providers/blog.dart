import 'dart:io';

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

  Future<void> publishBlog(String caption, String desc,
      [File post_photo,
      String place_id = null,
      File place_photo1,
      String place_name,
      String place_desc,
      List keywords,
      bool isSwitched = false]) async {
    const url = 'https://travellum.herokuapp.com/blogs-api/addblogs';
    final token = 'Bearer ' + authToken;

    Map<String, String> headers = {"Authorization": token};

    void handlePlaceData(http.MultipartRequest request) {
      if (isSwitched) {
        request.fields["place_name"] = place_name;
        request.fields["place_description"] = place_desc;
        request.fields["place_keywords"] = keywords.join(' ');
        request.fields['place_city'] = 'Kathmandu';
        request.fields['place_country'] = 'Nepal';
        request.files.add(
          http.MultipartFile.fromBytes(
            'place_photo1',
            place_photo1.readAsBytesSync(),
            filename: '${DateTime.now().toString()}.jpg',
          ),
        );
        request.headers.addAll(headers);

        // print('post published status: ${response.statusCode}');
        // print(json.decode(response.body));
      } else {
        request.fields["place_id"] = place_id;
        request.headers.addAll(headers);
      }
    }

    final request = new http.MultipartRequest('POST', Uri.parse(url));
    if (post_photo == null) {
      print('no photo for post');
      try {
        request.fields['title'] = caption;
        request.fields['description'] = desc;

        // print(caption);
        // print('isSwitched $isSwitched');
        // print(place_name + place_desc + keywords.join(' '));
        handlePlaceData(request);
        var response = await request.send();
        // print('Publish post Status Code: ${response.statusCode}');

        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });

        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    } else {
      try {
        request.fields['title'] = caption;
        request.fields['description'] = desc;

        handlePlaceData(request);
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo1',
            post_photo.readAsBytesSync(),
            filename: '${DateTime.now().toString()}.jpg',
          ),
        );
        request.headers.addAll(headers);

        var response = await request.send();
        print(response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        }));
        print('Publish Blog Status Code: ${response.statusCode}');
        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }
}
