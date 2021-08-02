import 'package:flutter/material.dart';
import '../screens/userBlogs_screen.dart';
import './fofo_list.dart';
import 'package:provider/provider.dart';
import '../providers/profile.dart';
import './message.dart';

class ProfileContainer extends StatefulWidget {
  Map<String, dynamic> profileContent;
  ProfileContainer(this.profileContent);

  @override
  _ProfileContainerState createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  bool _following = false;
  @override
  void initState() {
    _following = widget.profileContent['following'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String selfUserName = Provider.of<Profile>(context).username;
    final bool isMe = widget.profileContent['username'] == selfUserName;
    final String usernameInQUes =
        isMe ? selfUserName : widget.profileContent['username'];
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 20) * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage:
                          NetworkImage(widget.profileContent['photo_main']),
                      onBackgroundImageError:
                          (Object exception, StackTrace stackTrace) {
                        return Image.asset('./assets/images/guptaji.jpg');
                      },
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 20) * 0.7,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.profileContent['first_name']} ${widget.profileContent['last_name']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Kathmandu, Nepal",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      !isMe
                          ? Row(
                              children: [
                                Container(
                                  height: 28,
                                  margin: EdgeInsets.only(top: 6),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _following = !_following;
                                      });
                                      await Provider.of<Profile>(context,
                                              listen: false)
                                          .toogleFollow(widget
                                              .profileContent['username']);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      onPrimary: Colors.white,
                                    ),
                                    child: Text(
                                        _following ? "Following" : "Follow"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10, top: 6),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Message(
                                                '${widget.profileContent['first_name']} ${widget.profileContent['last_name']}',
                                                widget
                                                    .profileContent['username'],
                                                widget.profileContent['id']
                                                    .toString(),
                                                NetworkImage(
                                                    widget.profileContent[
                                                        'photo_main']))),
                                      );
                                    },
                                    icon: Icon(Icons.message),
                                    iconSize: 20,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEBEDEF),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
                // color: Color(0xFFEBEDEF),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.width - 20,
            margin: EdgeInsets.fromLTRB(10, 16, 10, 16),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => widget.profileContent['following_count'] == 0 ||
                          !_following
                      ? {}
                      : showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FoFo(true, usernameInQUes);
                          },
                        ),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEDEF),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${widget.profileContent['following_count']}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.profileContent['follower_count'] == 0 ||
                          !_following
                      ? {}
                      : showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext ctx) {
                            return FoFo(false, usernameInQUes);
                          },
                        ),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEDEF),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${widget.profileContent['follower_count']}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.profileContent['number of blogs'] == 0
                      ? {}
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UserBlogScreen(widget.profileContent['blogs']),
                          ),
                        ),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Color(0xFFEBEDEF),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Text(
                          widget.profileContent['number of blogs'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          'Blogs',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(children: [
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.black,
                  )),
            ),
            Text(
              "POSTS",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Divider(
                    color: Colors.black,
                  )),
            ),
          ]),
          //Own Feed
          //

          //End of feed section
        ],
      ),
    );
  }
}
