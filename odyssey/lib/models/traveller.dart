import 'package:flutter/foundation.dart';
import 'dart:io';

class Traveller {
  String username;
  String firstname;
  String lastname;
  String travellerId;
  String gender;
  String country;
  String city;
  String profilePicPath;

  Traveller({
    this.username,
    @required this.firstname,
    @required this.lastname,
    this.profilePicPath,
    this.gender,
    @required this.country,
    @required this.city,
    this.travellerId,
  });
}
