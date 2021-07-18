import 'package:meta/meta.dart';


class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;

  const Post({
    @required this.user,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.likes,
    @required this.comments,
    @required this.shares,
  });
}

class Blog {
  final User user;
  final String title;
  final String timeAgo;
  final String imageUrl;
  // final int likes;
  final int comments;
  final int shares;

  const Blog({
    @required this.user,
    @required this.title,
    @required this.timeAgo,
    @required this.imageUrl,
    // @required this.likes,
    @required this.comments,
    @required this.shares,
  });
}

class User {
  final String name;
  final String imageUrl;

  const User({
    @required this.name,
    @required this.imageUrl,
  });
}

class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    @required this.user,
    @required this.imageUrl,
    this.isViewed = false,
  });
}