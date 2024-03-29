import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/notification.dart' as noti;
import 'package:jiffy/jiffy.dart';
import '../widgets/empty.dart';
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
      var notis = await Provider.of<noti.Notification>(context, listen: false)
          .getAllNotifications();
      setState(() {
        allNotifications = notis;
      });
      print('all noti ${allNotifications.length}');
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getAllNotifications,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              floating: true,
              title: Container(
                child: Text(
                  "Notifications",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder(
              future: _fbuilder, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => LinearProgressIndicator()))
                      : allNotifications.isEmpty
                          ? emptySliver(false)
                          : SliverList(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        child: CircleAvatar(
                                            radius: 18.0,
                                            backgroundColor: Colors.grey[200],
                                            backgroundImage: NetworkImage(
                                                allNotifications[index]
                                                    ['sender']['photo_main']),
                                            onBackgroundImageError:
                                                (Object exception,
                                                    StackTrace stackTrace) {
                                              return Image.asset(
                                                  './assets/images/guptaji.jpg');
                                            }),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            allNotifications[index]['noti_type']
                                                        ['category'] ==
                                                    'FOLLOW'
                                                ? '$senderName started following  you'
                                                : allNotifications[index]
                                                                ['noti_type']
                                                            ['category'] ==
                                                        'CHAT'
                                                    ? '$senderName messaged you '
                                                    : "$senderName  liked your ${allNotifications[index]['noti_type']['category'].toLowerCase()} ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Jiffy(DateTime.parse(
                                                    allNotifications[index]
                                                        ['time']))
                                                .fromNow()
                                                .toString()
                                                .contains(RegExp(
                                                    r'hours|hour|minutes|seconds'))
                                            ? Text(
                                                Jiffy(DateTime.parse(
                                                        allNotifications[index]
                                                            ['time']))
                                                    .fromNow(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : Text(
                                                DateFormat('MMM dd, yyyy')
                                                    .format(DateTime.parse(
                                                        allNotifications[index]
                                                            ['time'])),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: 12,
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
      ),
    );
  }
}
