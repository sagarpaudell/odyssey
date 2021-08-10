import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../screens/single_blog_screen.dart';
import '../screens/profile_self.dart';
import '../screens/profile_user.dart';
import '../providers/blog.dart';
import 'package:odyssey/widgets/profile_avatar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

class BlogContainer extends StatefulWidget {
  final Map<String, dynamic> singleBlog;
  final Function fun;

  const BlogContainer(this.singleBlog, [this.fun]);

  @override
  _BlogContainerState createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  bool _is_bookmarked = false;
  void toggleBookmark(bool selectBlog) {
    if (widget.fun != null) {
      widget.fun(selectBlog);
    }
    setState(() {
      _is_bookmarked = !_is_bookmarked;
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.singleBlog['is_bookmarked']) {
      _is_bookmarked = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String selfUserName =
        Provider.of<Auth>(context, listen: false).userName;

    // final bool isDesktop = Responsive.isDesktop(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 3,
          ),
          // boxShadow: [BoxShadow(
          //   // blurRadius: ,

          // )],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image(
                  image: NetworkImage(widget.singleBlog["photo1"]),
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Image.asset('./assets/images/mana.jpg');
                  },
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 15, 2),
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor.withOpacity(0.2),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(widget.singleBlog['place']['name']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _BlogInfo(widget.singleBlog, selfUserName, context,
                  toggleBookmark, _is_bookmarked),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _BlogInfo(Map<String, dynamic> singleBlog, String selfUserName,
    BuildContext context, Function toggleB, bool _is_bookmarked) {
  final authData = Provider.of<Auth>(context, listen: false);
  // print('singleBlog:$singleBlog');
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Text(
        singleBlog['title'],
        style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8),
      ),

      SizedBox(
        height: 20,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                if (singleBlog['author']['username'] == selfUserName) {
                  Navigator.of(context)
                      .pushReplacementNamed(SelfProfile.routeName);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          UserProfile(singleBlog['author']['username']),
                    ),
                  );
                }
              },
              child:
                  ProfileAvatar(imageUrl: singleBlog['author']['photo_main'])),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${singleBlog['author']['username']}',
                style: const TextStyle(
                  // fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Jiffy(DateTime.parse(singleBlog['date']))
                      .fromNow()
                      .toString()
                      .contains(RegExp(r'hours|minutes|seconds'))
                  ? Text(
                      Jiffy(DateTime.parse(singleBlog['date'])).fromNow(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    )
                  : Text(
                      DateFormat('MMM dd, yyyy')
                          .format(DateTime.parse(singleBlog['date'])),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
              // Text(
              //   DateFormat('MMM dd, yyyy')
              //       .format(DateTime.parse(singleBlog['date'])),
              //   style: const TextStyle(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 14,
              //   ),
              // ),
              // Text(
              //   '{singleBlog.timeAgo}',
              //   style: const TextStyle(
              //     // fontWeight: FontWeight.w600,
              //     fontSize: 14,
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                authData.userName == singleBlog['author']['username']
                    ? GestureDetector(
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Confirm?'),
                                    content: Text(
                                        'Are you sure you want to delete this post?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context, 'OK');
                                          await Provider.of<Blog>(context,
                                                  listen: false)
                                              .deleteBlog(singleBlog['id']);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Post Sucessfully Deleted'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          // fetchUserPosts();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Provider.of<Blog>(context, listen: false)
                          .toogleBookmarkedBlog(singleBlog['id'].toString());
                      toggleB(true);
                    },
                    icon: _is_bookmarked
                        ? Icon(
                            Icons.bookmark,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          )
                        : Icon(
                            Icons.bookmark_border_outlined,
                            size: 24,
                          ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlogScreen(singleBlog['id']),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // const Divider(),
    ],
  );
}
