import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class MessageContainer extends StatefulWidget {
  @override
  final Map<String, dynamic> msg;
  final String selfUserName;
  final ImageProvider friendImage;

  const MessageContainer(this.selfUserName, this.msg, this.friendImage, key)
      : super(key: key);
  //MessageContainer(this.selfUserName, this.msg);
  _MessageContainerState createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Color senderColor = Color(0xffF0F0F0);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.msg['sender']['username'] != widget.selfUserName
              ?
              //Others message
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: widget.friendImage == null
                            ? AssetImage('./assets/images/guptaji.jpg')
                            : widget.friendImage,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      decoration: BoxDecoration(
                          color: senderColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              // height: 40,
                              // width: 40,
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
                          FocusedMenuHolder(
                            onPressed: () {
                              print('hi');
                            },
                            menuItems: [
                              FocusedMenuItem(
                                title: Text(DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.parse(
                                            widget.msg['message_time'])
                                        .add(Duration(hours: 5, minutes: 45)))
                                    .toString()),
                                // trailingIcon: Icon(Icons.delete),
                                onPressed: () {
                                  print('hi');
                                },
                              )
                            ],
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    widget.msg['message_text'],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  DateFormat.jm()
                                      .format(
                                        DateTime.parse(
                                                widget.msg['message_time'])
                                            .add(Duration(
                                                hours: 5, minutes: 45)),
                                      )
                                      .toString(),
                                  // '2021/12/20',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 11),
                                ),
                              ],
                            ),
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
                    bottom: 4,
                    right: 8,
                  ),
                  // width: MediaQuery.of(context).size.width * 0.55,
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
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
                        // FocusedMenuHolder(
                        //   onPressed: () {},
                        //   menuItems: [
                        //     FocusedMenuItem(
                        //       title: Text('Delete Comment'),
                        //       trailingIcon: Icon(Icons.delete),
                        //       onPressed: () {
                        //         print('hi');
                        //       },
                        //     )
                        //   ],
                        //   child: Text('hi'),
                        // ),
                        FocusedMenuHolder(
                            onPressed: () {
                              print('hi');
                            },
                            menuItems: [
                              FocusedMenuItem(
                                title: Text(DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.parse(
                                            widget.msg['message_time'])
                                        .add(Duration(hours: 5, minutes: 45)))
                                    .toString()),
                                // trailingIcon: Icon(Icons.delete),
                                onPressed: () {
                                  print('hi');
                                },
                              )
                            ],
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    // "Hello! How are you doing? hehehehehe",
                                    widget.msg['message_text'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                // Jiffy(DateTime.parse(widget.msg['message_time']))
                                //         .fromNow()
                                //         .toString()
                                //         .contains(RegExp(r'hours|minutes|seconds'))
                                //     ? Text(
                                //         Jiffy(DateTime.parse(widget.msg['message_time']))
                                //             .fromNow(),
                                //         style: const TextStyle(
                                //             color: Colors.white70, fontSize: 11),
                                //       )
                                //     : Text(
                                //         DateFormat('MMM dd, yyyy').format(
                                //             DateTime.parse(widget.msg['message_time'])),
                                //         style: const TextStyle(
                                //             color: Colors.white70, fontSize: 11),
                                //       ),
                                Text(
                                  DateFormat.jm()
                                      .format(DateTime.parse(
                                              widget.msg['message_time'])
                                          .add(Duration(hours: 5, minutes: 45)))
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 11),
                                )
                              ],
                            )),
                      ]),
                ),
        ],
      ),
    );
  }
}
