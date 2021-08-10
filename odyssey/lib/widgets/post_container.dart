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
import 'package:odyssey/providers/auth.dart';

import 'auth_card.dart';

class PostContainer extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function fun;
  final Function fetchUserPosts;
  final authData;

  PostContainer({
    Key key,
    @required this.post,
    this.fun,
    this.fetchUserPosts,
    this.authData,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState(
        fetchUserPosts: fetchUserPosts,
      );
}

class _PostContainerState extends State<PostContainer> {
  bool _is_bookmarked = false;
  int _like_counter;
  bool is_liked;

  _PostContainerState({
    Function fetchUserPosts,
  });

  // void initState() {
  //   super.initState();
  //   _like_counter = widget.post['like_users'].toList().length ~/ 2;
  // }

  void toggleBookmark(bool selectBlog) {
    if (widget.fun != null) {
      widget.fun(selectBlog);
    }
    setState(() {
      _is_bookmarked = !_is_bookmarked;
    });
  }

  void toggleLikes() async {
    // await Provider.of<Posts>(context, listen: false).toggleLike(widget.post['id']);
    // await widget.fetchUserPosts();
    // print(widget.post);
    // print(widget.post['like_users']);

    bool flag = await (widget.post['like_users'].length != 0)
        ? widget.post['like_users']

            // .contains('id=${authData.userId}, ${authData.userName}')
            .contains('${widget.authData.userName}(${widget.authData.userId})')
        // .contains('ketone(3) ')
        : false;
    // print(['ketone(3)', 'sagar(4)']);
    // print('flag:$flag');
    // print(widget.post['like_users']);
    // print('${widget.authData.userName}(${widget.authData.userId})');
    if (flag) {
      setState(() async {
        is_liked = false;
        print('is_liked: $is_liked');
        _like_counter -= 1;
        await Provider.of<Posts>(context, listen: false)
            .toggleLike(widget.post['id']);
        widget.fetchUserPosts();
      });
    } else {
      setState(() async {
        is_liked = true;
        print('is_liked: $is_liked');

        _like_counter += 1;
        await Provider.of<Posts>(context, listen: false)
            .toggleLike(widget.post['id']);
        widget.fetchUserPosts();
      });
    }
    // await print(authData.userName);
    // await print(widget.post['like_users']);
    // await print('flag:$flag');
    setState(() {
      // print((widget.post['like_users'].toList().length != 0));
      // print('flag: $flag');
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
    final authData = Provider.of<Auth>(context, listen: false);
    // _like_counter = widget.post['like_users'].toList().length ~/ 2;
    _like_counter = widget.post['like_users'].toList().length;

    is_liked = (widget.post['like_users'].length != 0)
        ? widget.post['like_users']
            .contains('${authData.userName}(${authData.userId})')
        : false;

    final String selfUserName = Provider.of<Auth>(
      context,
      listen: false,
    ).userName;

    // final test = widget.post['like_users'].toList();
    // print('test: ${test.runtimeType}');
    // print('test: ${test}');
    // final test2 = authData.toString();
    // print('test2: ${test2.runtimeType}');
    // final test3 = widget.post['like_users'].toList() != null;
    // print(test3);
    // List test4 = [];
    // print(test4.toList().length == 1);

    // print(widget.post['like_users']);
    // print((widget.post['like_users'].toList().length != 0));
    // print(flag);

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
                  _PostHeader(
                    widget.post,
                    selfUserName,
                    context,
                    widget.fetchUserPosts,
                  ),
                  const SizedBox(height: 10.0),
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
                _is_bookmarked,
                _like_counter,
                is_liked,
                widget.fetchUserPosts,
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
Widget _PostHeader(Map<String, dynamic> post, String selfUserName,
    BuildContext context, Function fetchUserPosts) {
  final authData = Provider.of<Auth>(context, listen: false);

  return Row(
    children: [
      GestureDetector(
        onTap: () {
          if (post['traveller']['username'] == selfUserName) {
            Navigator.of(context).pushNamed(SelfProfile.routeName);
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
      authData.userId.toString() == post['traveller']['id'].toString()
          ? FocusedMenuHolder(
              openWithTap: true,
              onPressed: () {},
              menuItems: [
                // FocusedMenuItem(
                //   title: Text('Edit Post'),
                //   trailingIcon: Icon(Icons.edit),
                //   onPressed: () {},
                // ),
                FocusedMenuItem(
                  title: Text('Delete Post'),
                  trailingIcon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<Posts>(context, listen: false)
                        .deletePost(post['id']);
                    fetchUserPosts();
                  },
                ),
              ],
              child: Icon(Icons.more_horiz)
              // IconButton(
              // icon: const Icon(Icons.more_horiz),
              // onPressed: () {
              // print(authData.userId);
              // print(post['traveller']['id']);
              // },
              // ),
              )
          : SizedBox(),
    ],
  );
}

Widget _PostButtons(
  Map<String, dynamic> post,
  BuildContext context,
  Function toggleB,
  Function toggleL,
  bool _is_bookmarked,
  int _like_counter,
  bool is_liked,
  Function fetchUserPosts,
) {
  // print('flag: $flag');
  // print(post);
  return Column(
    children: [
      const SizedBox(height: 8.0),

      Row(
        children: [
          is_liked
              ? GestureDetector(
                  onTap: () {
                    toggleL();
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
                builder: (_) => Comment(post['comments'], post, fetchUserPosts),
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
          // const SizedBox(width: 2.0),
          IconButton(
            onPressed: () {
              Provider.of<Posts>(context, listen: false)
                  .toogleBookmarkedPost(post['id'].toString());
              toggleB(false);
            },
            icon: _is_bookmarked
                ? Icon(
                    Icons.bookmark,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  )
                : Icon(
                    Icons.bookmark_border_outlined,
                    size: 24,
                  ),
          ),

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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 15, 2),
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor.withOpacity(0.2),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(post['place']['name']),
                    ],
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
