import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:odyssey/widgets/message.dart';
import 'package:provider/provider.dart';
import '../providers/chat.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<dynamic> chatOverview;
  Future fbuilder;
  final baseurl = 'https://travellum.herokuapp.com';
  @override
  void initState() {
    fbuilder = getMessageOverview();
    super.initState();
  }

  Future<void> getMessageOverview() async {
    try {
      chatOverview =
          await Provider.of<Chat>(context, listen: false).getChatOverview();
    } catch (error) {
      print(error);
    }
  }

  String formatter(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String uploadurl) {
    String url = formatter(uploadurl);
    return NetworkImage(url);
  }

  bool isMe = false;
  String selectedFriendName;
  String selectedFriendUserName;
  String selectedFriendId;
  ImageProvider friendImage;
  bool checkIsMe(String userName, String checkName) {
    return userName == checkName;
  }

  String getFriendName(Map<String, dynamic> chatOverview) {
    isMe
        ? selectedFriendName =
            '${chatOverview['receiver']['first_name']} ${chatOverview['receiver']['last_name']}'
        : selectedFriendName =
            '${chatOverview['sender']['first_name']} ${chatOverview['sender']['last_name']}';
    return selectedFriendName;
  }

  String getFriendUserName(Map<String, dynamic> chatOverview) {
    isMe
        ? selectedFriendUserName = '${chatOverview['receiver']['username']}'
        : selectedFriendUserName = '${chatOverview['sender']['username']}';
    return selectedFriendUserName;
  }

  String getFriendId(Map<String, dynamic> chatOverview) {
    isMe
        ? selectedFriendId = '${chatOverview['receiver']['id']}'
        : selectedFriendId = '${chatOverview['sender']['id']}';
    return selectedFriendId;
  }

  ImageProvider getFriendImage(Map<String, dynamic> chatOverview) {
    isMe
        ? chatOverview['receiver']['photo_main'] == null
            ? friendImage = AssetImage('./assets/images/guptaji.jpg')
            : friendImage = getImage(chatOverview['receiver']['photo_main'])
        : chatOverview['sender']['photo_main'] == null
            ? friendImage = AssetImage('./assets/images/guptaji.jpg')
            : friendImage = getImage(chatOverview['sender']['photo_main']);
    return friendImage;
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<Chat>(context).username;

    Size deviceSize = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future: fbuilder, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) => snapshot
                  .connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: chatOverview.length,
                itemBuilder: (BuildContext context, int index) {
                  isMe = checkIsMe(
                      userName, chatOverview[index]['sender']['username']);

                  return InkWell(
                    onTap: () {
                      isMe = checkIsMe(
                          userName, chatOverview[index]['sender']['username']);
                      print(getFriendName(chatOverview[index]));
                      getFriendImage(chatOverview[index]);
                      // Provider.of<Chat>(context, listen: false).friendUserName =
                      //     getFriendUserName(chatOverview[index]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Message(
                                selectedFriendName,
                                getFriendUserName(chatOverview[index]),
                                getFriendId(chatOverview[index]),
                                friendImage)),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundImage:
                                        getFriendImage(chatOverview[index]),
                                    onBackgroundImageError: (Object exception,
                                        StackTrace stackTrace) {
                                      setState(() {
                                        return Image.asset(
                                            './assets/images/guptaji.jpg');
                                      });
                                    },
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getFriendName(chatOverview[index]),
                                        // isMe
                                        //     ? '${chatOverview[index]['receiver']['first_name']} ${chatOverview[index]['receiver']['last_name']}'
                                        //     : '${chatOverview[index]['sender']['first_name']} ${chatOverview[index]['sender']['last_name']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 6),
                                      Opacity(
                                        opacity: 0.9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: deviceSize.width * 0.45,
                                              child: Text(
                                                chatOverview[index]
                                                    ['message_text'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 0),
                                              width: deviceSize.width * 0.18,
                                              child: Text(
                                                  DateFormat.yMd().format(
                                                      DateTime.parse(
                                                          chatOverview[index][
                                                              'message_time'])),
                                                  //11:49 a.m

                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 80,
                          ),
                          child: Opacity(
                            opacity: 0.4,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
