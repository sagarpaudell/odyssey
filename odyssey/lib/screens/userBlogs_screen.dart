import 'package:flutter/material.dart';
import '../widgets/blog_container.dart';

class UserBlogScreen extends StatelessWidget {
  final List<dynamic> userBlogs;
  UserBlogScreen(this.userBlogs);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return BlogContainer(userBlogs[index]);
        },
        itemCount: userBlogs.length,
      ),
    );
  }
}
