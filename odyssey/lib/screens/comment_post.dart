import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class Comment extends StatelessWidget {
  bool comments = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          Expanded(
            child: comments ? Comments() : NoComments(),
          ),
          PostComment(),
        ],
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        FocusedMenuHolder(
          menuItems: [
            FocusedMenuItem(
              title: Text('Delete Comment'),
              trailingIcon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
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
                    backgroundImage: NetworkImage(
                        'https://source.unsplash.com/random/50x50'),
                  ),
                  title: Text(
                    'Samesh Bajracharya',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('1 hour ago'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit',
                    style: TextStyle(
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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

class PostComment extends StatelessWidget {
  const PostComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write a comment',
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: null,
        )
      ],
    );
  }
}
