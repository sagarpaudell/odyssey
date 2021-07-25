import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile.dart';
import '../widgets/profile_container.dart';
import '../widgets/post_container.dart';

class UserProfile extends StatefulWidget {
  String friendUserName;
  UserProfile(this.friendUserName);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future fbuilder;
  Map<String, dynamic> friendProfileData;

  @override
  void initState() {
    fbuilder = getUserProfile();
    super.initState();
  }

  Future<void> getUserProfile() async {
    try {
      friendProfileData = await Provider.of<Profile>(context, listen: false)
          .getFriendProfile(widget.friendUserName);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    const choices = ['blockuser', 'logout'];

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
            onPressed: () {},
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
      if (choice == 'blockuser') {
        print('Block');
      } else if (choice == 'logout') {
        showAlertDialog(context);
      }
    }

    iconValue(choice) {
      if (choice == 'blockuser') {
        return Icons.block_flipped;
      } else if (choice == 'logout') {
        return Icons.logout;
      }
    }

    textValue(choice) {
      if (choice == 'blockuser') {
        return 'Block this user';
      } else if (choice == 'logout') {
        return 'Log Out';
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: ProfileContainer(friendProfileData),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return PostContainer(
                            post: friendProfileData['posts'][index]);
                      }, childCount: friendProfileData['posts'].length),
                    ),
                  ]),
      ),
    );
  }
}
