import 'package:flutter/material.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/screens/single_blog_screen.dart';
import 'package:odyssey/widgets/profile_avatar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

class BlogContainer extends StatelessWidget {
  final Map<String, dynamic> singleBlog;

  const BlogContainer(
    @required this.singleBlog,
  );

  @override
  Widget build(BuildContext context) {
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
            singleBlog["photo1"] == null
                ? Container(
                    child: Image(
                      image: NetworkImage(
                          'https://source.unsplash.com/random/400x250'),
                    ),
                  )
                : Image(
                    image: NetworkImage('https://travellum.herokuapp.com' +
                        singleBlog["photo1"]),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _BlogInfo(singleBlog),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogInfo extends StatelessWidget {
  final Map<String, dynamic> singleBlog;
  _BlogInfo(this.singleBlog);
  @override
  Widget build(BuildContext context) {
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
            //ProfileAvatar(imageUrl: singleBlog.user.imageUrl),
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
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(singleBlog['date'])),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
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
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.bookmark_border_outlined,
                      size: 24,
                      color: Colors.grey,
                    ),
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
                        color: Colors.grey,
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
}
