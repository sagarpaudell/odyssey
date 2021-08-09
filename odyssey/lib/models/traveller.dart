import 'package:flutter/foundation.dart';
import 'Package:image_picker/image_picker.dart';
import 'dart:io';

class Traveller {
  String firstname;
  String lastname;
  String phone;
  String travellerId;
  String gender;
  String country;
  String city;
  File profilePic;
  String profilePicUrl;

  Traveller({
    @required this.firstname,
    @required this.lastname,
    @required this.phone,
    this.profilePic,
    this.gender,
    @required this.country,
    @required this.city,
    this.travellerId,
    this.profilePicUrl,
  });
}
