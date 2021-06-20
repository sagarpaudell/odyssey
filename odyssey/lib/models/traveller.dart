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
  File profilePic;

  Traveller({
    @required this.username,
    @required this.firstname,
    @required this.lastname,
    @required this.profilePic,
    @required this.gender,
    @required this.country,
    @required this.city,
    @required this.travellerId,
  });
}
