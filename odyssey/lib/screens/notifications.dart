import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/notification.dart' as noti;
import 'package:jiffy/jiffy.dart';

import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  static const routeName = '/notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<dynamic> allNotifications;
  String notiCategory;
  String senderName;
  Future _fbuilder;
  @override
  void initState() {
    _fbuilder = getAllNotifications();
    super.initState();
  }

  Future<void> getAllNotifications() async {
    try {
      allNotifications =
          await Provider.of<noti.Notification>(context, listen: false)
              .getAllNotifications();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            floating: true,
            title: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(14),
                    child: Text(
                      "Notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      child: Text(
                    "mark as read",
                    style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: Colors.amber),
                  ))
                ],
              ),
            ),
          ),
          FutureBuilder<void>(
            future: _fbuilder, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => LinearProgressIndicator()))
                    :

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Divider(
                    //     color: Colors.black,
                    //   ),
                    // ), child:
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // switch (allNotifications[index]['noti_type']
                            //     ['category']) {
                            //   case 'POST':
                            //     notiCategory = 'post';
                            //     break;
                            //   case 'BLOG':
                            //     notiCategory = 'blog';
                            //     break;
                            //   case 'FOLLOW':
                            //     notiCategory = 'post';
                            //     break;

                            //   default:
                            // }
                            senderName =
                                '${allNotifications[index]['sender']['first_name']} ${allNotifications[index]['sender']['last_name']}';
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 18.0,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage: NetworkImage(
                                          allNotifications[index]['sender']
                                              ['photo_main']),
                                      onBackgroundImageError: (Object exception,
                                          StackTrace stackTrace) {
                                        return Image.asset(
                                            './assets/images/guptaji.jpg');
                                      }),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      allNotifications[index]['noti_type']
                                                  ['category'] ==
                                              'FOLLOW'
                                          ? ' $senderName started following  you'
                                          : allNotifications[index]['noti_type']
                                                      ['category'] ==
                                                  'CHAT'
                                              ? '$senderName messaged you '
                                              : "$senderName  liked your ${allNotifications[index]['noti_type']['category'].toLowerCase()} ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Jiffy(DateTime.parse(
                                              allNotifications[index]['time']))
                                          .fromNow()
                                          .toString()
                                          .contains(
                                              RegExp(r'hours|minutes|seconds'))
                                      ? Text(
                                          Jiffy(DateTime.parse(
                                                  allNotifications[index]
                                                      ['time']))
                                              .fromNow(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        )
                                      : Text(
                                          DateFormat('MMM dd, yyyy').format(
                                              DateTime.parse(
                                                  allNotifications[index]
                                                      ['time'])),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                          childCount: allNotifications.length,
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
