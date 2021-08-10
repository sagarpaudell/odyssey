import 'package:flutter/material.dart';

Widget emptySliver(bool feeds) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Card(
          shadowColor: Colors.white,
          margin: EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
            child: Center(
                child: Text(
              'No posts',
              style: TextStyle(fontSize: 30, color: Colors.red),
            )),
          ),
        );
      },
      childCount: 1,
    ),
  );
}
