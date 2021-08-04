import 'package:flutter/material.dart';
import 'package:odyssey/pages/edit_profile_page.dart';
import 'package:odyssey/screens/screens.dart';
import '../widgets/profile_container.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/profile.dart';
import '../widgets/post_container.dart';

class SelfProfile extends StatefulWidget {
  static const routeName = 'selfprofile';
  @override
  _SelfProfileState createState() => _SelfProfileState();
}

class _SelfProfileState extends State<SelfProfile> {
  static const choices = ['editprofile', 'opensettings', 'logout'];
  //List<dynamic> selfPosts;
  Map<String, dynamic> selfProfileData;

  Future _fbuilder;
  @override
  void initState() {
    _fbuilder = getSelfData();
    super.initState();
  }

  // Future<void> getSelfPosts() async {
  //   try {
  //     var temp =
  //         await Provider.of<Posts>(context, listen: false).getSelfPosts();
  //     setState(() {
  //       selfPosts = temp;
  //     });
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> getSelfData() async {
    final String uname = Provider.of<Auth>(context, listen: false).userName;
    try {
      selfProfileData = await Provider.of<Profile>(context, listen: false)
          .getFriendProfile(uname);
      print('this is selfdata $selfProfileData');
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {},
          ),
          TextButton(
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
              setState(
                  () => Provider.of<Auth>(context, listen: false).logout());
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
      if (choice == 'editprofile') {
        Navigator.of(context).pushNamed(EditProfilePage.routeName);
      } else if (choice == 'opensettings') {
      } else if (choice == 'logout') {
        showAlertDialog(context);
      }
    }

    iconValue(choice) {
      if (choice == 'editprofile') {
        return Icons.mode_edit;
      } else if (choice == 'opensettings') {
        return Icons.settings;
      } else if (choice == 'logout') {
        return Icons.logout;
      }
    }

    textValue(choice) {
      if (choice == 'editprofile') {
        return 'Edit Profile';
      } else if (choice == 'opensettings') {
        return 'Open Settings';
      } else if (choice == 'logout') {
        return 'Log Out';
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
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
                        color: choice == 'logout'
                            ? Colors.red[400]
                            : Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          textValue(choice),
                          style: TextStyle(
                              color: choice == 'logout'
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
      ),
      body: FutureBuilder<void>(
        future: _fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: ProfileContainer(selfProfileData),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return PostContainer(
                            post: selfProfileData['posts'][index]);
                      }, childCount: selfProfileData['posts'].length),
                    ),
                  ]),
      ),

      //  CustomScrollView(slivers: [
      //   SliverToBoxAdapter(
      //     child: ProfileContainer(selfProfileInfo),
      //   ),
      //   selfPosts == null
      //       ? SliverToBoxAdapter(child: CircularProgressIndicator())
      //       : SliverList(
      //           delegate: SliverChildBuilderDelegate(
      //               (BuildContext context, int index) {
      //             return PostContainer(post: selfPosts[index]);
      //           }, childCount: selfPosts.length),
      //         ),
      // ]),
    );
  }
}
