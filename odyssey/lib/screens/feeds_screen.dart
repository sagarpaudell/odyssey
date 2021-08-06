import 'package:flutter/material.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/data/data.dart';
import './bookmarks.dart';
import './chat_screen.dart';
import './comment_post.dart';
import '../widgets/fb_loading.dart';
import '../widgets/post_container.dart';
import '../widgets/blog_container.dart';
import './edit_profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../providers/blog.dart' as blogss;
import '../providers/auth.dart';
import 'package:rolling_switch/rolling_switch.dart';


// import '../themes/style.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeedsScreen extends StatefulWidget {

  static const routeName = '/feeds';

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  
  List<dynamic> userPosts;
  List<dynamic> allBlogs;
  bool isPosts = true;
  // final Posts = [{}];

  // @override
  // void initState() {
  //   Provider.of<Posts>(context, listen: false).getPosts();
  //   super.initState();
  // }

  fetchUserPosts() {
    Future fbuilder;
    fbuilder = getUserPosts();
  }

  @override
  void initState() {
    fetchUserPosts();
    super.initState();
  }

  Future<void> getUserPosts() async {
    var temp = await Provider.of<Posts>(context, listen: false).getPosts();
    setState(() {
      userPosts = temp;
    });
  }

  Future<void> getAllTheBlogs() async {
    List<dynamic> tempblogs =
        await Provider.of<blogss.Blog>(context, listen: false).getAllBlogs();
    setState(() {
      allBlogs = tempblogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor=Theme.of(context).primaryColor;
    if (!isPosts) {
      getAllTheBlogs();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height*0.09,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            floating: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Bookmark(selectPost: true),
                    ),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                  ),
                ),
                Container(
          
                  height: MediaQuery.of(context).size.height*0.07,
                  child: RollingSwitch.icon(
                    onChanged: (bool state) {
                      setState(() {
                        isPosts = !isPosts;
                      });
                    },
                    rollingInfoRight: const RollingIconInfo(
                      backgroundColor:Color(0xFF1C2E4A),
                      
                      icon: Icons.post_add,
                      text: Text('BLOGS', style: TextStyle(fontSize: 16),),
                    
                    ),
                    rollingInfoLeft: const RollingIconInfo(
                      icon: Icons.home,
                      backgroundColor: Colors.grey,
                      text: Text('POSTS', style: TextStyle(fontSize: 16),),
                    ),
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
                          return PostContainer(
                            post: userPosts[index],
                            fetchUserPosts: fetchUserPosts,
                          );
                        },
                        childCount: userPosts.length,
                      ),
                    )
              : allBlogs == null
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
                          return BlogContainer(
                            allBlogs[index],
                          );
                        },
                        childCount: allBlogs.length,
                      ),
                    )
        ],
      ),
    );
  }
}
