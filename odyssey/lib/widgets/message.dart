import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import '../providers/chat.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'messageContainer.dart';

class Message extends StatefulWidget {
  final String friendName;
  final ImageProvider friendImage;
  Message(this.friendName, this.friendImage);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // Size deviceSize = MediaQuery.of(context).size;
  Color bgColor = Color(0xffe8edea);
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
  List<Map<String, dynamic>> _chatMessages = [];
  List<dynamic> messageData;
  bool isInit = false;
  Future fbuilder;
  @override
  void initState() {
    fbuilder = getMessageData();
    isInit = true;
    super.initState();
  }

  Future<void> getMessageData() async {
    try {
      messageData =
          await Provider.of<Chat>(context, listen: false).getMessageHistory();
    } catch (error) {
      print(error);
    }
  }

  addImmediateMsg() {
    channel.stream.listen((message) {
      setState(() {
        _chatMessages.add({
          'sender': {'username': json.decode(message)['sender']},
          'message_text': json.decode(message)['message'],
          'message_time': json.decode(message)['time']
        });
      });
    });
  }

  @override
  // Future<void> initState() async {
  //   channel = Provider.of<Chat>(context).sendMessage();
  //   super.initState();
  // }
  void didChangeDependencies() {
    channel = Provider.of<Chat>(context, listen: false).sendMessage();
    if (isInit) {
      addImmediateMsg();
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

  // @override
  // void dispose() {
  //   channel.sink.close();
  //   _controller.dispose();
  //   super.dispose();
  // }

  final _controller = TextEditingController();

  //end of _messageBuilder
  _sendMessage() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 8, top: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        BoxShadow(
          color: Color(0xffb8c7be),
          blurRadius: 14,
        )
      ]),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    _sendMessageFun();
                    _controller.text = '';
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
        ),
      ),
    );
  }

  //end of _sendMessage
  void _sendMessageFun() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(json.encode({'message': _controller.text}));
    }
  }

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
    const choices=['viewprofile', 'blockuser','deleteconversation'];
      
    showAlertDialog(BuildContext context) {     
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to delete this conversation?"),
        actions: [
          TextButton(
          child: Text("Cancel"),
          onPressed:  () {},
          ),
          TextButton(
          child: Text("Yes, Delete", style: TextStyle(
          color: Colors.red[400],
          ),),
          onPressed:  () {},
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

  void choiceAction(String choice){
    if(choice =='viewprofile'){
     print('View profile');
    }
    else if(choice == 'blockuser'){
    print("blocked user");
    }
    else if(choice == 'deleteconversation'){
    showAlertDialog(context);
    }
  }

  iconValue(choice){
    if(choice =='viewprofile'){
     return Icons.account_circle;
    }
    else if(choice == 'blockuser'){
    return Icons.block_flipped;
    }
    else if(choice == 'deleteconversation'){
    return Icons.delete;
    }
  }

  textValue(choice){
     if(choice =='viewprofile'){
     return "View Profile";
    }
    else if(choice == 'blockuser'){
    return "Block this user";
    }
    else if(choice == 'deleteconversation'){
      return "Delete Conversation";
    
    }
  }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions:[
          PopupMenuButton(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  Icons.more_vert,
                  color:Colors.white,
                  size: 28,
                ),
              ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                        children: [
                          Icon(
                            iconValue(choice),
                            color:  choice=='deleteconversation'?Colors.red[400]: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              textValue(choice),
                              style: TextStyle(
                                  color: choice=='deleteconversation'?Colors.red[400]: Theme.of(context).primaryColor,
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
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
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
            Text(
              widget.friendName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
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
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                          ),
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    // To convert this infinite list to a list with three items,
                                    // uncomment the following line:
                                    // if (index > 3) return null;

                                    // return _messageBuilder(DateTime.parse(
                                    //     messageData[index]['message_time']));
                                    return Column(children: [
                                      if (index < messageData.length)
                                        MessageContainer(messageData[index]),
                                      if (_chatMessages.isNotEmpty &&
                                          index < _chatMessages.length)
                                        MessageContainer(_chatMessages[index]),
                                    ]);
                                    //return null;
                                  },
                                  // Or, uncomment the following line:
                                  // childCount: 3,
                                ),
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
                            ],
                          ),
                        ),
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
                      ),
                      _sendMessage(),
                    ],
                  ),
      ),
    );
  }
}
