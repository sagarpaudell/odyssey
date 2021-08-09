import 'package:flutter/material.dart';
import 'package:odyssey/screens/create.dart';
import 'package:odyssey/screens/explore.dart';
import 'package:odyssey/screens/screens.dart';
import 'package:odyssey/widgets/custom_tab_bar.dart';
import './profile_self.dart';
import 'notifications.dart';
import 'package:provider/provider.dart' as pro;
import '../providers/notification.dart' as noti;

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> newNoti = [];

  // Future _fbuilder;
  // @override
  // void initState() {
  //   _fbuilder = checkNoti();
  //   super.initState();
  // }

  // Future<void> checkNoti() async {
  //   var temp = await pro.Provider.of<noti.Notification>(context, listen: false)
  //       .checkNewNotifications();
  //   setState(() {
  //     newNoti = temp;
  //     print('newNoti $newNoti');
  //   });
  // }
  Future<void> checkNoti() async {
    newNoti = await pro.Provider.of<noti.Notification>(context, listen: false)
        .checkNewNotifications();
  }

  final List<Widget> _screens = [
    FeedsScreen(),
    Explore(),
    Create(),
    Notifications(),
    SelfProfile(),
  ];

  List<IconData> _icons = [
    Icons.home,
    Icons.explore,
    Icons.add_a_photo_outlined,
    Icons.notifications,
    Icons.person,
  ];
  List<IconData> _iconsN = [
    Icons.home,
    Icons.explore,
    Icons.add_a_photo_outlined,
    Icons.notifications_on,
    Icons.person,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body:
            //  FutureBuilder(
            //   future: checkNoti(),
            //   builder: (ctx, AsyncSnapshot snapshot) =>
            //       snapshot.connectionState == ConnectionState.waiting
            //           ? Center(child: CircularProgressIndicator())
            //           :

            IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          color: Colors.white,
          child: CustomTabBar(
            icons: newNoti.isEmpty ? _icons : _iconsN,
            selectedIndex: _selectedIndex,
            onTap: (index) async {
              await checkNoti();
              setState(() => _selectedIndex = index);
            },
          ),
        ),
      ),
    );
  }
}
