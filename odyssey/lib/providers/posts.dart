import 'package:flutter/widgets.dart';
import 'dart:convert';
import '../models/http_exception.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:odyssey/models/post.dart';
import 'dart:io';

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
  Future<List<dynamic>> getPosts(bool explore) async {
    String url;
    if (explore) {
      url = 'https://travellum.herokuapp.com/post-api/explore';
    } else {
      url = 'https://travellum.herokuapp.com/post-api/newsfeed';
    }
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

  Future<void> publishPost(String caption,
      [File post_photo,
      String place_id = null,
      File place_photo1,
      String place_name,
      String place_desc,
      List keywords,
      bool isSwitched = false]) async {
    const url = 'https://travellum.herokuapp.com/post-api/post';
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
        request.fields['caption'] = caption;

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
        final request = new http.MultipartRequest('POST', Uri.parse(url));
        request.fields['caption'] = caption;
        // handlePlaceData(request);
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo',
            post_photo.readAsBytesSync(),
            filename: '${DateTime.now().toString()}.jpg',
          ),
        );
        request.headers.addAll(headers);

        var response = await request.send();

        // print('Publish post Status Code: $response.statusCode');
        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  Future<void> deletePost(int postId) async {
    final url = 'https://travellum.herokuapp.com/post-api/post/$postId';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      print(response.body);

      notifyListeners();
    } catch (error) {
      print(json.decode(error));
      throw error;
    }
  }

  Future<void> toggleLike(int postId) async {
    final url = 'https://travellum.herokuapp.com/post-api/like/$postId';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      print('Response: ${response.body}');

      notifyListeners();
    } catch (error) {
      print(json.decode(error));
      throw error;
    }
  }

  Future<List<dynamic>> getPostsByPlace(String id) async {   
    final url = 'https://travellum.herokuapp.com/post-api/place/$id';
    
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final postData = json.decode(userDataResponse.body);
      print(postData);
      notifyListeners();
      return postData;
    } catch (e) {
      print(e);
    }
  }

}

