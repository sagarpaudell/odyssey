// import 'dart:js';

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:odyssey/providers/auth.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:provider/provider.dart';
import '../functions/dateformatter.dart';

class Comment extends StatelessWidget {
  List<dynamic> commentData;
  Map<String, dynamic> post;
  Function fetchUserPosts;
  Comment(this.commentData, this.post, this.fetchUserPosts);

  @override
  Widget build(BuildContext context) {
    print('postid: ${post['id']}');
    print(commentData);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Comments',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: commentData.isEmpty
                  ? NoComments()
                  : Comments(commentData, context),
            ),
            PostComment(context, post['id'], fetchUserPosts),
          ],
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  List<dynamic> commentData;
  BuildContext context;
  Comments(this.commentData, this.context);

  @override
  Widget build(BuildContext context) {
    print(commentData);
    final authData = Provider.of<Auth>(context, listen: false);

    return ListView.builder(
        itemBuilder: (ctx, index) => Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                FocusedMenuHolder(
                  onPressed: () {
                    // print(authData.userId ==
                    //     commentData[index][authData.userName]['id']);
                    print(authData.userName);
                  },
                  menuItems: authData.userId ==
                          commentData[index]['traveller']['id'].toString()
                      ? [
                          FocusedMenuItem(
                            title: Text('Delete Comment'),
                            trailingIcon: Icon(Icons.delete),
                            onPressed: () {},
                          ),
                          // FocusedMenuItem(
                          //   backgroundColor: Colors.white.withOpacity(0),
                          //   title: Text(''),
                          //   onPressed: () {},
                          //   // trailingIcon: Icon(Icons.delete),
                          // ),
                        ]
                      : [],
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(commentData[index]
                                    ['traveller']['photo_main']),
                                onBackgroundImageError:
                                    (Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      './assets/images/guptaji.jpg');
                                }),
                            title: Text(
                              '${commentData[index]['traveller']['first_name']} ${commentData[index]['traveller']['last_name']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: DateFormatter(
                                commentData[index]['comment_time'])),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                          child: Row(
                            children: [
                              Text(
                                commentData[index]['comment'],
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        itemCount: commentData.length);
  }
}

class NoComments extends StatelessWidget {
  const NoComments({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No comments to show."),
        ],
      ),
    );
  }
}

Widget PostComment(
  BuildContext context,
  int post_id,
  Function fetchUserPosts,
) {
  final _commentController = TextEditingController();
  print(post_id);
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment',
            ),
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () async {
          Navigator.pop(context);
          await Provider.of<Posts>(context, listen: false)
              .postComment(post_id, _commentController.text);
          _commentController.clear();
          fetchUserPosts();
        },
      )
    ],
  );
}
