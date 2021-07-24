import 'package:flutter/material.dart';
import 'package:odyssey/widgets/profile_avatar.dart';
import 'package:provider/provider.dart';
import '../providers/blog.dart';
import './profile_user.dart';

class BlogScreen extends StatefulWidget {
  final int blogId;
  BlogScreen(this.blogId);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  Future fbuilder;
  Map<String, dynamic> singleBlogData;
  @override
  void initState() {
    fbuilder = getUserPosts();
    super.initState();
  }

  Future<void> getUserPosts() async {
    singleBlogData = await Provider.of<Blog>(context, listen: false)
        .getBlogById(widget.blogId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(singleBlogData['photo1']),
                        ),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Odyssey • July 20, 2021",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      height: 1.5,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                singleBlogData['title'],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 28,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                singleBlogData['description'],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UserProfile(
                                        singleBlogData['author']['id']),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ProfileAvatar(
                                      imageUrl: singleBlogData['author']
                                          ['photo_main'],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // '${blog.user.name}',
                                          singleBlogData['author']['username'],
                                          style: const TextStyle(
                                            // fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          // '${blog.timeAgo}',
                                          'Traveller',
                                          style: const TextStyle(
                                            // fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
