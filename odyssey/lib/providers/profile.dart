import 'package:flutter/widgets.dart';
import 'dart:convert';

import '../models/traveller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:io';

class Profile with ChangeNotifier {
  Traveller travellerUser;
  final String userId;
  final String username;
  final String authToken;

  Profile([this.username, this.userId, this.authToken, this.travellerUser]);

  Future<void> editProfile(Traveller profile) async {
    const url = 'https://travellum.herokuapp.com/traveller-api/';
    final token = 'Bearer ' + authToken;

    Map<String, String> headers = {"Authorization": token};

    //final bytes = await profile.profilePic.readAsBytes();
    try {
      final request = new http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['first_name'] = profile.firstname;
      request.fields['last_name'] = profile.lastname;
      request.fields['country'] = profile.country;
      request.fields['city'] = profile.city;
      request.fields['contact_no'] = profile.phone;
      if (profile.profilePic != null) {
        print('here');
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo_main',
            profile.profilePic.readAsBytesSync(),
            filename: '$userId.jpg',
          ),
        );
      }
      request.headers.addAll(headers);

      var response = await request.send();
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Future<void> tempProfile(File pickedImg) async {
  //   const url = 'https://travellum.herokuapp.com/traveller-api/';
  //   final token = 'Bearer ' + authToken;
  //   print('dio');

  //   try {
  //     FormData formData = new FormData.fromMap({
  //       "photo_main":
  //           await MultipartFile.fromFile(pickedImg.path, filename: "photo_main")
  //     });

  //     Response response = await Dio().put(url,
  //         data: formData,
  //         options: Options(headers: <String, String>{
  //           'Authorization': token,
  //         }));
  //     print(response);
  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response);
  //     return e.response;

  //   } catch (e) {}
  // }

  Future<Traveller> getProfile() async {
    const url = 'https://travellum.herokuapp.com/traveller-api/';
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final userData = json.decode(userDataResponse.body);

      final userProfile = Traveller(
        firstname: userData['first_name'],
        lastname: userData['last_name'],
        country: userData['country'],
        city: userData['city'],
        profilePicUrl: userData['photo_main'],
      );

      notifyListeners();
      return userProfile;
    } catch (error) {
      print(json.decode(error));
      throw error;
    }
  }

  Future<Map<String, dynamic>> getFriendProfile(String friendUserName) async {
    final url = 'https://travellum.herokuapp.com/traveller-api/$friendUserName';
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final friendData = json.decode(userDataResponse.body);

      notifyListeners();

      return friendData;
    } catch (error) {
      throw error;
    }
  }

  Future<void> toogleFollow(String uname) async {
    final url =
        'https://travellum.herokuapp.com/traveller-api/follow-user/$uname';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      print(json.decode(response.body));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getSelfFollowers() async {
    final url = 'https://travellum.herokuapp.com/traveller-api/followers';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getSelfFollowing() async {
    final url = 'https://travellum.herokuapp.com/traveller-api/following';
    final token = 'Bearer ' + authToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
