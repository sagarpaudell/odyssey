import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

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

    try {
      final request = new http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['first_name'] = profile.firstname;
      request.fields['last_name'] = profile.lastname;
      request.fields['country'] = profile.country;
      request.fields['city'] = profile.city;
      request.fields['first_name'] = profile.firstname;
      request.headers.addAll(headers);

      var response = await request.send();
      //print(response.statusCode);
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
    print('getprofile');
    const url = 'https://travellum.herokuapp.com/traveller-api/';
    final token = 'Bearer ' + authToken;
    try {
      final userDataResponse = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
      final userData = json.decode(userDataResponse.body);

      final userProfile = Traveller(
        username: userData['username'],
        firstname: userData['first_name'],
        lastname: userData['last_name'],
        country: userData['country'],
        city: userData['city'],
      );

      print(userDataResponse.statusCode);
      notifyListeners();
      return userProfile;
    } catch (error) {
      print(json.decode(error));
      throw error;
    }
  }
}
