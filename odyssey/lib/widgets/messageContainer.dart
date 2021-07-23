import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageContainer extends StatefulWidget {
  @override
  final Map<String, dynamic> msg;
  MessageContainer(this.msg);
  _MessageContainerState createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.msg['sender']['username'] != "ketone"
              ?
              //Others message
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage:
                            AssetImage('./assets/images/guptaji.jpg'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            // child: StreamBuilder(
                            //   stream: channel.stream,
                            //   builder: (context, snapshot) {
                            //     return snapshot.hasError
                            //         ? Text(
                            //             snapshot.error.toString(),
                            //             style: TextStyle(
                            //                 color: Theme.of(context).primaryColor,
                            //                 fontSize: 8),
                            //           )
                            //         : Text(
                            //             snapshot.hasData
                            //                 ? json.decode(
                            //                             snapshot.data)['sender'] !=
                            //                         "ketone"
                            //                     ? json.decode(
                            //                         snapshot.data)['message']
                            //                     : 'Text'
                            //                 : '',
                            //             style: TextStyle(
                            //                 color: Theme.of(context).primaryColor,
                            //                 fontSize: 15),
                            //           );
                            //   },
                            // ),
                          ),
                          Text(
                            widget.msg['message_text'],
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat.yMd().format(
                                DateTime.parse(widget.msg['message_time'])),
                            // '2021/12/20',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              :

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
                      // child: StreamBuilder(
                      //   stream: channel.stream,
                      //   builder: (context, snapshot) {
                      //     debugPrint(snapshot.data);
                      //     return snapshot.hasError
                      //         ? Text(
                      //             snapshot.error.toString(),
                      //             style: TextStyle(
                      //                 color: Theme.of(context).primaryColor,
                      //                 fontSize: 8),
                      //           )
                      //         : Text(
                      //             snapshot.hasData
                      //                 ? json.decode(
                      //                             snapshot.data)['sender'] ==
                      //                         "ketone"
                      //                     ? json.decode(
                      //                         snapshot.data)['message']
                      //                     : 'Text'
                      //                 : '',
                      //             style: TextStyle(
                      //                 color: Theme.of(context).primaryColor,
                      //                 fontSize: 15),
                      //           );
                      //   },
                      // ),
                      // ),
                      Text(
                        // "Hello! How are you doing? hehehehehe",
                        widget.msg['message_text'],
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        DateFormat.yMd()
                            .format(DateTime.parse(widget.msg['message_time'])),
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      )
                    ],
                  )),
        ],
      ),
    );
  }
}