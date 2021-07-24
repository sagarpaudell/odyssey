import 'package:flutter/material.dart';
import 'package:odyssey/widgets/chat_list.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = '/chat';
}

class _ChatScreenState extends State<ChatScreen> {
  String profilePicUrl;

  @override
  Widget build(BuildContext context) {
    profilePicUrl =
        Provider.of<Auth>(context, listen: false).userProfileInfo['photo_main'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 18,
                child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(profilePicUrl),
                    onBackgroundImageError:
                        (Object exception, StackTrace stackTrace) {
                      return Image.asset('./assets/images/guptaji.jpg');
                    }),
              ),
            ),
          ],
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
              onPressed: () => Navigator.pop(context, false)),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color:  Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChatList(),
          ),
        ));
  }
}
