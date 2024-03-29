import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:odyssey/screens/chat_screen.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import '../providers/chat.dart';
import '../providers/auth.dart';
import 'dart:async';

import 'dart:convert';
import './messageContainer.dart';
import '../screens/profile_user.dart';

class Message extends StatefulWidget {
  final String friendUserName;
  final String friendName;
  final String friendId;
  final bool pop;
  final ImageProvider friendImage;
  Message(this.friendName, this.friendUserName, this.friendId, this.friendImage,
      this.pop);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // Size deviceSize = MediaQuery.of(context).size;
  Color bgColor = Colors.white;

  // final channel = WebSocketChannel.connect(
  //   Uri.parse('wss://echo.websocket.org'),
  // );
  // static const friend = "buddha";
  // static const token =
  //     //"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI0ODc2MjEyLCJqdGkiOiIwNmNhMjM3ZGNhMjc0NGVmOTdiYTZjYTljZTNkMTlmNSIsInVzZXJfaWQiOjV9.vNA_E42HrrUDpETXysim0BYVx39qsmovqvD0RSlIilE";
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI0ODcyMjY0LCJqdGkiOiIzZTBiMjM4ZWE5NTA0MjJmYWM2NjYxMzg5MjM1YjFiYSIsInVzZXJfaWQiOjN9.Z9TwDwEIUAhefhBQk01cmALCBjimtT11CIheOy9QQ3k";
  // final channel = WebSocketChannel.connect(
  //     Uri.parse("ws://travellum.herokuapp.com/ws/chat/$friend/?token=$token"));
  WebSocketChannel channel;
  //List<Map<String, dynamic>> _chatMessages = [];
  List<dynamic> messageData;
  bool isInit = false;
  Future fbuilder;

  String selfUserName;
  @override
  void initState() {
    fbuilder = getMessageData();

    isInit = true;
    super.initState();
  }

  Future<void> getMessageData() async {
    try {
      messageData = await Provider.of<Chat>(context, listen: false)
          .getMessageHistory(widget.friendUserName);
    } catch (error) {
      print(error);
    }
  }

  // addImmediateMsg() {
  //   channel.stream.listen((message) {
  //     print(message);
  //     setState(() {
  //       _chatMessages.add({
  //         'sender': {'username': json.decode(message)['sender']},
  //         'message_text': json.decode(message)['message'],
  //         'message_time': json.decode(message)['time']
  //       });
  //     });
  //   });
  //   print(_chatMessages);
  // }

  @override
  // Future<void> initState() async {
  //   channel = Provider.of<Chat>(context).sendMessage();
  //   super.initState();
  // }
  void didChangeDependencies() {
    if (isInit) {
      channel = Provider.of<Chat>(context).sendMessage(widget.friendUserName);
      Provider.of<Chat>(context).addImmediateMsg();
    }
    isInit = false;

    super.didChangeDependencies();
  }
  // channel.stream.listen((message) { print(message); })
// @override
  // initState() {
  //   super.initState();
  //   channel.stream.listen(this.onData, onError: onError, onDone: onDone);

  //   (() async {
  //     setState(() {});
  //   });
  // }

  // onDone() {
  //   debugPrint("Socket is closed");
  // }

  // onError(err) {
  //   debugPrint(err.runtimeType.toString());
  //   WebSocketChannelException ex = err;
  //   debugPrint(ex.message);
  // }

  // onData(event) {
  //   debugPrint(event);
  // }

  @override
  void dispose() {
    //print('is dispoded');
    // Provider.of<Chat>(context).setChatMessagesEmpty();
    //channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  final _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  //end of _messageBuilder
  _sendMessage() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        onTap: () => Timer(
          Duration(milliseconds: 300),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent),
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              onPressed: () {
                _sendMessageFun();
              }),
          contentPadding: EdgeInsets.only(
            left: 30,
            right: 50,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 0.1),
          ),
          hintText: "Write a message",
        ),
      ),
    );
  }

  //end of _sendMessage

// Widget StreamBuilder(
//                           stream: channel.stream,
//                           builder: (context, snapshot) {
//                             return snapshot.hasError
//                                 ? Text(
//                                     snapshot.error.toString(),
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontSize: 8),
//                                   )
//                                 : Text(
//                                     snapshot.hasData
//                                         ? json.decode(snapshot.data)['sender'] ==
//                                                 "ketone"
//                                             ? json.decode(snapshot.data)['message']
//                                             : 'Text'
//                                         : '',
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontSize: 15),
//                                   );
//                           },
//                         ),
//                       );

  @override
  Widget build(BuildContext context) {
    selfUserName = Provider.of<Auth>(context).userName;
    const choices = ['viewprofile', 'deleteconversation'];

    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to delete this conversation?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Yes, Delete",
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            onPressed: () async {
              await Provider.of<Chat>(context, listen: false)
                  .deleteChat(widget.friendUserName);
              int count = 0;
              widget.pop
                  ? Navigator.of(context).popUntil((_) => count++ >= 2)
                  : Navigator.of(context).pushNamed(ChatScreen.routeName);
            },
          ),
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    //end of confirmatin box

    void choiceAction(String choice) {
      if (choice == 'viewprofile') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserProfile(widget.friendUserName),
          ),
        );
      } else if (choice == 'blockuser') {
        print("blocked user");
      } else if (choice == 'deleteconversation') {
        showAlertDialog(context);
      }
    }

    iconValue(choice) {
      if (choice == 'viewprofile') {
        return Icons.account_circle;
      } else if (choice == 'blockuser') {
        return Icons.block_flipped;
      } else if (choice == 'deleteconversation') {
        return Icons.delete;
      }
    }

    textValue(choice) {
      if (choice == 'viewprofile') {
        return "View Profile";
      } else if (choice == 'blockuser') {
        return "Block this user";
      } else if (choice == 'deleteconversation') {
        return "Delete Conversation";
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        actions: [
          PopupMenuButton(
            child: Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 28,
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(
                        iconValue(choice),
                        color: choice == 'deleteconversation'
                            ? Colors.red[400]
                            : Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          textValue(choice),
                          style: TextStyle(
                              color: choice == 'deleteconversation'
                                  ? Colors.red[400]
                                  : Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Provider.of<Chat>(context, listen: false).setChatMessagesEmpty();
            channel.sink.close();
            _controller.text = '';
            Navigator.of(context).popAndPushNamed(ChatScreen.routeName);
          },
        ),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 18,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: widget.friendImage,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent[400],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Text(
                  widget.friendName,
                  overflow: TextOverflow.visible, //temporary fix
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfile(widget.friendUserName),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                          ),
                          child: Consumer<Chat>(
                            builder: (context, chat, child) {
                              print('current message is ${chat.chatMessages}');
                              return CustomScrollView(
                                  controller: _scrollController,
                                  slivers: [
                                    child,
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                        // if (_chatMessages.isNotEmpty &&
                                        //     index < _chatMessages.length)
                                        return MessageContainer(
                                            selfUserName,
                                            chat.chatMessages[index],
                                            widget.friendImage,
                                            UniqueKey());
                                      }, childCount: chat.chatMessages.length),
                                    ),
                                  ]);
                            },
                            child: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                // To convert this infinite list to a list with three items,
                                // uncomment the following line:
                                // if (index > 3) return null;

                                // return _messageBuilder(DateTime.parse(
                                //     messageData[index]['message_time']));

                                return MessageContainer(
                                    selfUserName,
                                    messageData[index],
                                    widget.friendImage,
                                    UniqueKey());
                              },
                                  childCount: messageData == null
                                      ? 0
                                      : messageData.length),
                            ),
                          ),
                          //return null;
                        ),
                        // Or, uncomment the following line:
                        // childCount: 3,
                      ),

                      // child: ListView(
                      //   //reverse: true,
                      //   shrinkWrap: true,
                      //   children: [
                      //     for (var msg in messageData)
                      //       MessageContainer(msg),
                      //     for (var immediateMsg in _chatMessages)
                      //       if (_chatMessages.isNotEmpty)
                      //         MessageContainer(immediateMsg),
                      //   ],
                      // ),

                      //     child: ListView.builder(
                      //         physics: ClampingScrollPhysics(),
                      //         reverse: true, //displays messages from bottom
                      //         itemCount: messageData.length,
                      //         itemBuilder: (ctx, int index) {
                      //           // return _messageBuilder(DateTime.parse(
                      //           //     messageData[index]['message_time']));
                      //           return MessageContainer(messageData[index]);
                      //         }),
                      //   ),
                      // ),
                      // _chatMessages.isEmpty
                      //     ? SizedBox()
                      //     : Expanded(
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             color: bgColor,
                      //           ),
                      //           child: ListView.builder(
                      //               physics: ClampingScrollPhysics(),
                      //               itemCount: _chatMessages.length,
                      //               itemBuilder: (context, index) {
                      //                 return MessageContainer(
                      //                     _chatMessages[index]);
                      //               }),
                      //         ),

                      _sendMessage(),
                    ],
                  ),
      ),
    );
  }

  void _sendMessageFun() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(json.encode({'message': _controller.text}));
      _controller.text = '';
      Timer(
          Duration(milliseconds: 500),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
  }
}
