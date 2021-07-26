import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:jiffy/jiffy.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:odyssey/screens/comment_post.dart';
import 'package:odyssey/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import '../screens/profile_self.dart';
import '../screens/profile_user.dart';

import '../providers/auth.dart';
import 'package:provider/provider.dart';

class PostContainer extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function fun;
  const PostContainer({Key key, @required this.post, this.fun})
      : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  bool _is_bookmarked = false;
  bool _is_liked = false;
  int _like_counter = 0;

  void toggleBookmark() {
    if (widget.fun != null) {
      widget.fun();
    }
    setState(() {
      _is_bookmarked = !_is_bookmarked;
    });
  }

  void toggleLikes() {
    _is_liked = !_is_liked;
  }

  void like() {
    setState(() {
      _like_counter += 1;
    });
  }

  void unlike() {
    setState(() {
      _like_counter -= 1;
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.post['is_bookmarked']) {
      _is_bookmarked = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String selfUserName = Provider.of<Auth>(context).userName;

    return Card(
      shadowColor: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(widget.post, selfUserName, context),
                  const SizedBox(height: 4.0),
                  Text(widget.post['caption']),
                  widget.post['photo_main'] != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 14.0),
                ],
              ),
            ),
            widget.post['photo'] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image(
                      image: NetworkImage(
                        widget.post["photo"],
                      ),
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image.asset('./assets/images/mana.jpg');
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _PostButtons(
                widget.post,
                context,
                toggleBookmark,
                toggleLikes,
                like,
                unlike,
                _is_bookmarked,
                _is_liked,
                _like_counter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _PostHeader extends StatelessWidget {
//   final Map<String, dynamic> post;

//   const _PostHeader({
//     Key key,
//     @required this.post,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
Widget _PostHeader(
    Map<String, dynamic> post, String selfUserName, BuildContext context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          if (post['traveller']['username'] == selfUserName) {
            Navigator.of(context).pushReplacementNamed(SelfProfile.routeName);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UserProfile(post['traveller']['username']),
              ),
            );
          }
        },
        child: ProfileAvatar(imageUrl: post['traveller']['photo_main']),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${post['traveller']['username']} • ',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Jiffy(DateTime.parse(post['post_time']))
                    .fromNow()
                    .toString()
                    .contains(RegExp(r'hours|minutes|seconds'))
                ? Text(
                    Jiffy(DateTime.parse(post['post_time'])).fromNow(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    DateFormat('MMM dd, yyyy')
                        .format(DateTime.parse(post['post_time'])),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ],
        ),
      ),
      FocusedMenuHolder(
        openWithTap: true,
        onPressed: () {},
        menuItems: [
          FocusedMenuItem(
            title: Text('Delete Post'),
            trailingIcon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
        child: IconButton(
          icon: const Icon(Icons.more_horiz),
          // onPressed: () => print('hello'),
        ),
      ),
    ],
  );
}

Widget _PostButtons(
  Map<String, dynamic> post,
  BuildContext context,
  Function toggleB,
  Function toggleL,
  Function like,
  Function unlike,
  bool _is_bookmarked,
  bool _is_liked,
  int _like_counter,
) {
  return Column(
    children: [
      const SizedBox(height: 8.0),

      Row(
        children: [
          _is_liked
              ? GestureDetector(
                  onTap: () {
                    toggleL();
                    unlike();
                  },
                  child: Container(
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      // color: Theme.of(context).primaryColorDark,
                      color: Colors.blue,
                      size: 27.0,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    toggleL();
                    like();
                  },
                  // onTap: () {
                  //   print('hi');
                  // },
                  child: Container(
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey[700],
                      size: 25.0,
                    ),
                  ),
                ),
          const SizedBox(width: 4.0),
          Text(
            // '${post["like_users"].length}',
            '${_like_counter}',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(width: 8.0),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Comment(),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.comment_outlined,
                  color: Colors.grey[700],
                  size: 25.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '${post["comments"].length}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          // const Icon(
          //   Icons.share_outlined,
          //   size: 24.0,
          // ),
          // const SizedBox(width: 4.0),
          // Text(
          //   '0',
          //   style: TextStyle(
          //     color: Colors.grey[600],
          //   ),
          // ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<Posts>(context, listen: false)
                        .toogleBookmarkedPost(post['id'].toString());
                    toggleB();
                  },
                  icon: _is_bookmarked
                      ? Icon(
                          Icons.bookmark,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        )
                      : Icon(
                          Icons.bookmark_border_outlined,
                          size: 24,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4.0),
        ],
      ),
      // const Divider(),
      const SizedBox(height: 12.0),
    ],
  );
}
