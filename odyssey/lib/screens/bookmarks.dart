import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You haven't bookmarked any posts."),
                ],
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(12.0),
          //         child: TextField(
          //           decoration: InputDecoration(
          //             hintText: 'Write a comment',
          //           ),
          //         ),
          //       ),
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.send),
          //       onPressed: null,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
