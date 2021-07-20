import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import '../providers/chat.dart';
import 'dart:convert';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // Size deviceSize = MediaQuery.of(context).size;
  Color bgColor = Color(0xffe8edea);
  // final _channel = WebSocketChannel.connect(
  //   Uri.parse('wss://echo.websocket.org'),
  // );
  // static const friend = "buddha";
  // static const token =
  //     //"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI0ODc2MjEyLCJqdGkiOiIwNmNhMjM3ZGNhMjc0NGVmOTdiYTZjYTljZTNkMTlmNSIsInVzZXJfaWQiOjV9.vNA_E42HrrUDpETXysim0BYVx39qsmovqvD0RSlIilE";
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI0ODcyMjY0LCJqdGkiOiIzZTBiMjM4ZWE5NTA0MjJmYWM2NjYxMzg5MjM1YjFiYSIsInVzZXJfaWQiOjN9.Z9TwDwEIUAhefhBQk01cmALCBjimtT11CIheOy9QQ3k";
  // final _channel = WebSocketChannel.connect(
  //     Uri.parse("ws://travellum.herokuapp.com/ws/chat/$friend/?token=$token"));
  WebSocketChannel _channel;
  //OWebSocketChannel channel;

  @override
  // Future<void> initState() async {
  //   _channel = Provider.of<Chat>(context).sendMessage();
  //   super.initState();
  // }
  void didChangeDependencies() {
    _channel = Provider.of<Chat>(context, listen: false).sendMessage();
    super.didChangeDependencies();
  }
  // @override
  // initState() {
  //   super.initState();
  //   _channel.stream.listen(this.onData, onError: onError, onDone: onDone);

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
  //   _channel.sink.close();
  //   _controller.dispose();
  //   super.dispose();
  // }

  final _controller = TextEditingController();
  _messageBuilder() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //Others message
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage('./assets/images/guptaji.jpg'),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: StreamBuilder(
                          stream: _channel.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasError
                                ? Text(
                                    snapshot.error.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 8),
                                  )
                                : Text(
                                    snapshot.hasData
                                        ? json.decode(
                                                    snapshot.data)['sender'] !=
                                                "ketone"
                                            ? json.decode(
                                                snapshot.data)['message']
                                            : 'Text'
                                        : '',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15),
                                  );
                          },
                        ),
                      ),
                      // Text(
                      //   "hello..ihihihihihi",
                      //   style: TextStyle(
                      //       color: Theme.of(context).primaryColor,
                      //       fontSize: 15),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '2021/12/20',
                        style: TextStyle(color: Colors.black54, fontSize: 11),
                      )
                    ],
                  )),
            ],
          ),

          //User's  sent message
          Container(
              margin: EdgeInsets.only(
                top: 8,
                right: 8,
              ),
              width: MediaQuery.of(context).size.width * 0.55,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 40,
                  //   width: 40,
                  //   child: StreamBuilder(
                  //     stream: _channel.stream,
                  //     builder: (context, snapshot) {
                  //       return snapshot.hasError
                  //           ? Text(
                  //               snapshot.error.toString(),
                  //               style: TextStyle(
                  //                   color: Theme.of(context).primaryColor,
                  //                   fontSize: 8),
                  //             )
                  //           : Text(
                  //               snapshot.hasData
                  //                   ? json.decode(snapshot.data)['sender'] ==
                  //                           "ketone"
                  //                       ? json.decode(snapshot.data)['message']
                  //                       : 'Text'
                  //                   : '',
                  //               style: TextStyle(
                  //                   color: Theme.of(context).primaryColor,
                  //                   fontSize: 15),
                  //             );
                  //     },
                  //   ),
                  // ),
                  Text(
                    // "Hello! How are you doing? hehehehehe",
                    _controller.text,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '2021/12/20',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  )
                ],
              )),
        ],
      ),
    );
  }

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
                onPressed: _sendMessageFun,
              ),
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
    Provider.of<Chat>(context, listen: false).getMessageHistory();
    // if (_controller.text.isNotEmpty) {
    //   _channel.sink.add(json.encode({'message': _controller.text}));
    // }
  }

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
                      backgroundImage:
                          AssetImage('./assets/images/guptaji.jpg'),
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
              'Deependra Gupta',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
              ),
              child: ListView.builder(
                  reverse: true, //displays messages from bottom
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int nothing) {
                    return _messageBuilder();
                  }),
            ),
          ),
          _sendMessage(),
        ],
      ),
    );
  }
}
