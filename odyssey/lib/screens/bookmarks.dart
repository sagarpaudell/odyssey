import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odyssey/screens/screens.dart';
import './main_screen.dart';

import '../providers/posts.dart';
import '../providers/blog.dart' as blogss;
import 'package:provider/provider.dart';
import '../widgets/fb_loading.dart';
import '../widgets/post_container.dart';
import '../widgets/blog_container.dart';

class Bookmark extends StatefulWidget {
  final bool selectPost;

  static const routeName = '/bookmark';
  Bookmark({this.selectPost});
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<bool> isSelected;
  List<dynamic> bookmarkedPosts;
  // List<dynamic> bookmarkedBlogs;
  bool isPosts;

  void refreshBookmark([bool selectBlog]) {
    if (selectBlog) {
      print('reloading blogs');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Bookmark(selectPost: false),
        ),
      );
    } else {
      print('reloading posts');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Bookmark(selectPost: true),
        ),
      );
    }
  }

  Future fbuilder;
  @override
  void initState() {
    isSelected = [widget.selectPost, !widget.selectPost];
    isPosts = widget.selectPost;
    fbuilder = getBPosts();
    super.initState();
  }

  Future<void> getBPosts() async {
    var temp =
        await Provider.of<Posts>(context, listen: false).getBookmarkedPosts();

    setState(() {
      bookmarkedPosts = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (!isPosts) {
    //   getBookmarkedBlogs();
    // }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,

            floating: true,
            // appBar: AppBar(
            title: Text('Bookmarks'),
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () =>
                  Navigator.popAndPushNamed(context, MainScreen.routeName),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ToggleButtons(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Posts',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Blogs',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                    fillColor: Theme.of(context).primaryColor,
                    selectedColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    highlightColor: Colors.blueGrey,
                    isSelected: isSelected,
                    renderBorder: false,
                    borderRadius: BorderRadius.circular(20),
                    onPressed: (int index) {
                      setState(() {
                        isPosts = !isPosts;
                        for (int indexBtn = 0;
                            indexBtn < isSelected.length;
                            indexBtn++) {
                          if (indexBtn == index) {
                            isSelected[indexBtn] = true;

                            if (index == 0) {
                              isPosts = true;
                            } else {
                              isPosts = false;
                            }
                          } else {
                            isSelected[indexBtn] = false;
                          }
                        }
                      });
                    },
                  ),
                ),
              );
            },
            childCount: 1,
          )),
          isPosts
              ? PostContent(fbuilder, bookmarkedPosts, refreshBookmark)
              : BlogContent(context, refreshBookmark)
        ],
      ),
    );
  }
}

Widget PostContent(
    Future fbuilder, List<dynamic> bookmarkedPosts, Function refreshBookmark) {
  return FutureBuilder<void>(
    future: fbuilder, // a previously-obtained Future<String> or null
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return FbLoading();
                  },
                  childCount: 1,
                ),
              )
            : bookmarkedPosts.isEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Center(
                        child: Text("You haven't bookmarked any Posts."),
                      );
                    }, childCount: 1),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PostContainer(
                          post: bookmarkedPosts[index], fun: refreshBookmark);
                    },
                    childCount: bookmarkedPosts.length,
                  )),
  );
}

Widget BlogContent(BuildContext context, Function refreshBookmark) {
  List<dynamic> bookmarkedBlogs;

  Future<void> getBookmarkedBlogs() async {
    bookmarkedBlogs = await Provider.of<blogss.Blog>(context, listen: false)
        .getBookmarkedBlogs();
  }

  ;

  return FutureBuilder<void>(
    future: getBookmarkedBlogs(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return FbLoading();
                  },
                  childCount: 1,
                ),
              )
            : bookmarkedBlogs.isEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Center(
                        child: Text("You haven't bookmarked any Blogs."),
                      );
                    }, childCount: 1),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return BlogContainer(
                            bookmarkedBlogs[index], refreshBookmark);
                      },
                      childCount: bookmarkedBlogs.length,
                    ),
                  ),
  );
}
