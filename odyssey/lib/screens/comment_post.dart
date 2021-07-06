import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios),
            ),
            Expanded(
              child: Center(child: Text('Comments')),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No comments to show."),
                ],
              ),
            ),
          ),
          Row(
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
          ),
        ],
      ),
    );
  }
}
