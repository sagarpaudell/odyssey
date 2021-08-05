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
  bool isPosts = true;
  List<dynamic> bookmarkedPosts;
  List<dynamic> bookmarkedBlogs;
  void refreshBookmark([bool selectBlog]) {
    if (selectBlog) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Bookmark(selectPost: false),
        ),
      );
    } else {
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

  Future<void> getBookmarkedBlogs() async {
    List<dynamic> tempblogs =
        await Provider.of<blogss.Blog>(context, listen: false)
            .getBookmarkedBlogs();
    setState(() {
      bookmarkedBlogs = tempblogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isPosts) {
      getBookmarkedBlogs();
    }
    return Scaffold(
      appBar: AppBar(
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ToggleButtons(
                children: [
                  Text(
                    'Posts',
                  ),
                  Text('Blogs')
                ],
                borderRadius: BorderRadius.circular(20),
                borderColor: Theme.of(context).primaryColor,
                borderWidth: 1,
                isSelected: isSelected,
                selectedColor: Colors.white,
                splashColor: Colors.lightBlue,
                fillColor: Theme.of(context).primaryColor,
                onPressed: (int index) {
                  setState(() {
                    for (int indexBtn = 0;
                        indexBtn < isSelected.length;
                        indexBtn++) {
                      if (indexBtn == index) {
                        isSelected[indexBtn] = !isSelected[indexBtn];
                      } else {
                        isSelected[indexBtn] = false;
                      }
                    }
                    isPosts = !isPosts;
                  });
                },
              ),
            ),
          ),
          isPosts
              ? PostContent(fbuilder, bookmarkedPosts, refreshBookmark)
              : BlogContent(bookmarkedBlogs, refreshBookmark)
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
            ? FbLoading()
            : bookmarkedPosts.isEmpty
                ? Center(
                    child: Text("You haven't bookmarked any posts."),
                  )
                : Expanded(
                    child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PostContainer(
                          post: bookmarkedPosts[index], fun: refreshBookmark);
                    },
                    itemCount: bookmarkedPosts.length,
                  )),
  );
}

Widget BlogContent(List<dynamic> bookmarkedBlogs, Function refreshBookmark) {
  return bookmarkedBlogs == null
      ? FbLoading()
      : bookmarkedBlogs.isEmpty
          ? Center(
              child: Text("You haven't bookmarked any Blogs."),
            )
          : Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BlogContainer(bookmarkedBlogs[index], refreshBookmark);
                },
                itemCount: bookmarkedBlogs.length,
              ),
            );
}
