import 'package:flutter/material.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/data/data.dart';
import 'package:odyssey/screens/bookmarks.dart';
import 'package:odyssey/screens/chat_screen.dart';
import 'package:odyssey/screens/comment_post.dart';
import 'package:odyssey/widgets/fb_loading.dart';
import 'package:odyssey/widgets/post_container.dart';
import 'package:odyssey/widgets/blog_container.dart';
import 'edit_profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/posts.dart';
// import '../themes/style.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/feeds';

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<dynamic> userPosts;

  // final Posts = [{}];

  // @override
  // void initState() {
  //   Provider.of<Posts>(context, listen: false).getPosts();
  //   super.initState();
  // }

  Future fbuilder;
  @override
  void initState() {
    fbuilder = getUserPosts();
    super.initState();
  }

  Future<void> getUserPosts() async {
    var temp = await Provider.of<Posts>(context, listen: false).getPosts();
    setState(() {
      userPosts = temp;
      print('userPosts: $userPosts');
    });
  }

  var isPosts = true;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    // return Scaffold(
    //   body: Container(
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text(
    //             'Feeds ${authData.userName}',
    //             style: TextStyle(
    //               fontSize: 40,
    //             ),
    //           ),
    //           ElevatedButton(
    //             onPressed: () =>
    //                 Navigator.of(context).pushNamed(EditProfilePage.routeName),
    //             child: Text('add profile'),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            floating: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Bookmark(),
                    ),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPosts = !isPosts;
                    });
                  },
                  child: Image.asset(
                    'assets/images/logoonly.png',
                    height: 40.0,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          isPosts
              ? userPosts == null
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return FbLoading();
                        },
                        childCount: 1,
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return PostContainer(post: userPosts[index]);
                        },
                        childCount: userPosts.length,
                      ),
                    )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Blog blog = blogs[index];
                      return BlogContainer(blog: blog);
                    },
                    childCount: blogs.length,
                  ),
                )
        ],
      ),
    );
  }
}
