import 'package:flutter/foundation.dart';
import 'Package:image_picker/image_picker.dart';

class Traveller {
  String username;
  String firstname;
  String lastname;
  String travellerId;
  String gender;
  String country;
  String city;
  PickedFile profilePic;

  Traveller({
    this.username,
    @required this.firstname,
    @required this.lastname,
    this.profilePic,
    this.gender,
    @required this.country,
    @required this.city,
    this.travellerId,
  });
}
