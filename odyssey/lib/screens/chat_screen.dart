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

  Future<void> getProf() async {
    prof = await Provider.of<Profile>(context, listen: false).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
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
                            backgroundColor: Colors.greenAccent[400],
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: prof == null
                                  ? AssetImage('./assets/images/guptaji.jpg')
                                  : NetworkImage(
                                      'https://travellum.herokuapp.com${prof.profilePicUrl}'),
                            ),
                          ),
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
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 40,
                  child: TextField(
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).primaryColor),
                      contentPadding: EdgeInsets.only(bottom: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      hintText: "Search people/messages",
                    ),
                  ),
                ),
              ),
              ChatList(),
            ]),
          ),
        ));
  }
}
