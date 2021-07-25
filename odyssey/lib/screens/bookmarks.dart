import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/posts.dart';
import '../providers/blog.dart' as blogss;
import 'package:provider/provider.dart';
import '../widgets/fb_loading.dart';
import '../widgets/post_container.dart';
import '../widgets/blog_container.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  List<bool> isSelected = [true, false];
  bool isPosts = true;
  List<dynamic> bookmarkedPosts;
  List<dynamic> bookmarkedBlogs;
  void refreshBookmark() {
    initState();
  }

  Future fbuilder;
  @override
  void initState() {
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
      ),
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? SingleChildScrollView(child: FbLoading())
                : bookmarkedPosts.isEmpty
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You haven't bookmarked any posts."),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                        isSelected[indexBtn] =
                                            !isSelected[indexBtn];
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
                          Expanded(
                            child: isPosts
                                ? ListView.builder(
                                    itemBuilder: (context, index) {
                                      return PostContainer(
                                          post: bookmarkedPosts[index],
                                          fun: refreshBookmark);
                                    },
                                    itemCount: bookmarkedPosts.length,
                                  )
                                : bookmarkedBlogs == null
                                    ? SingleChildScrollView(child: FbLoading())
                                    : bookmarkedBlogs.isEmpty
                                        ? Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "You haven't bookmarked any posts."),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            itemBuilder: (context, index) {
                                              return BlogContainer(
                                                  bookmarkedBlogs[index]);
                                            },
                                            itemCount: bookmarkedBlogs.length,
                                          ),
                          ),
                        ],

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
                      ),
      ),
    );
  }
}
