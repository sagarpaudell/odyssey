import 'package:flutter/material.dart';
import 'package:odyssey/widgets/chat_list.dart';
import '../providers/profile.dart';
import 'package:provider/provider.dart';
import '../models/traveller.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = '/chat';
}

class _ChatScreenState extends State<ChatScreen> {
  Future fbuilder;
  Traveller prof;
  @override
  void initState() {
    fbuilder = getProf();

    super.initState();
  }

  Color bgColor = Color(0xffe8edea);
  Future<void> getProf() async {
    prof = await Provider.of<Profile>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: FutureBuilder<void>(
                future:
                    fbuilder, // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CircleAvatar(
                            radius: 18,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  'https://travellum.herokuapp.com${prof.profilePicUrl}'),
                              onBackgroundImageError:
                                  (Object exception, StackTrace stackTrace) {
                                setState(() {
                                  return Image.asset(
                                      './assets/images/guptaji.jpg');
                                });
                              },
                            ),
                          ),
              ),
            ),
          ],
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: bgColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ChatList(),
          ),
        ));
  }
}
