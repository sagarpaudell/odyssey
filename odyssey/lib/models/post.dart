import 'Package:image_picker/image_picker.dart';
import 'package:odyssey/models/traveller.dart';
import 'package:odyssey/models/place.dart';

class Post {
  String postId;
  Traveller traveller;
  String caption;
  Place place;
  List like_users;
  List comment;
  DateTime post_time;
  PickedFile photo;

  Post({
    this.postId,
    this.traveller,
    this.caption,
    this.place,
    this.like_users,
    this.comment,
    this.post_time,
    this.photo,
  });
}
