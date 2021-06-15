import 'package:flutter/foundation.dart';
import 'dart:io';

class Traveller {
  final String userName;
  final String travellerId;
  final String gender;
  final File profilePic;

  Traveller({
    @required this.userName,
    @required this.profilePic,
    @required this.gender,
    @required this.travellerId,
  });
}
