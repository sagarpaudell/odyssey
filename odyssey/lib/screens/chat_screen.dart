import 'package:flutter/material.dart';
import 'package:odyssey/widgets/chat_list.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static const routeName = '/chat';
}

class _ChatScreenState extends State<ChatScreen> {
  Color bgColor = Color(0xffe8edea);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.greenAccent[400],
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('./assets/images/samesh.jpg'),
                ),
              ),
            )
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios),
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
