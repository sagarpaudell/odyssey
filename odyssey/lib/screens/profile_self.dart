import 'package:flutter/material.dart';
import 'package:odyssey/pages/edit_profile_page.dart';
import '../widgets/profile_container.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class SelfProfile extends StatefulWidget {
  static const routeName = 'selfprofile';
  @override
  _SelfProfileState createState() => _SelfProfileState();
}

class _SelfProfileState extends State<SelfProfile> {
  static const choices = ['editprofile', 'opensettings', 'logout'];
  @override
  Widget build(BuildContext context) {
    var selfProfileInfo = Provider.of<Auth>(context).userProfileInfo;

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
      body: ProfileContainer(selfProfileInfo),
      // body: Column(
      //   children: [
      //     Container(
      //       child: Row(
      //         children: [
      //           Container(
      //             width: (MediaQuery.of(context).size.width - 20) * 0.3,
      //             child: Padding(
      //               padding: const EdgeInsets.only(left: 10, top: 10),
      //               child: CircleAvatar(
      //                 radius: 52,
      //                 backgroundImage: AssetImage('./assets/images/samesh.jpg'),
      //               ),
      //             ),
      //           ),
      //           Container(
      //             width: (MediaQuery.of(context).size.width - 20) * 0.7,
      //             margin: EdgeInsets.all(10),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   "Samesh Bajracharya",
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.w600),
      //                 ),
      //                 SizedBox(
      //                   height: 4,
      //                 ),
      //                 Text(
      //                   "Kathmandu, Nepal",
      //                   maxLines: 1,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: TextStyle(
      //                       fontSize: 16, fontWeight: FontWeight.w400),
      //                 ),
      //                 OutlinedButton(
      //                   onPressed: () {},
      //                   child: Text("View messages  "),
      //                   style: OutlinedButton.styleFrom(
      //                     primary: Theme.of(context).primaryColor,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     Container(
      //       padding: EdgeInsets.only(top: 16, bottom: 16),
      //       decoration: BoxDecoration(
      //           boxShadow: [
      //             BoxShadow(
      //               color: Color(0xFFEBEDEF),
      //               blurRadius: 30,
      //               spreadRadius: 2,
      //             ),
      //           ],
      //           color: Color(0xFFEBEDEF),
      //           borderRadius: BorderRadius.all(Radius.circular(10))),
      //       width: MediaQuery.of(context).size.width - 20,
      //       margin: EdgeInsets.fromLTRB(10, 16, 10, 16),
      //       child: Wrap(
      //         direction: Axis.horizontal,
      //         alignment: WrapAlignment.spaceEvenly,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.all(4),
      //             decoration: BoxDecoration(
      //               color: Color(0xFFEBEDEF),
      //             ),
      //             child: Column(
      //               children: [
      //                 Text(
      //                   "120",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //                 Text(
      //                   'Places Visited',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.all(4),
      //             decoration: BoxDecoration(
      //               color: Color(0xFFEBEDEF),
      //             ),
      //             child: Column(
      //               children: [
      //                 Text(
      //                   "12.1k",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //                 Text(
      //                   'Followers',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.all(4),
      //             decoration: BoxDecoration(
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Theme.of(context).primaryColor,
      //                     spreadRadius: 1,
      //                   ),
      //                 ],
      //                 color: Color(0xFFEBEDEF),
      //                 borderRadius: BorderRadius.all(Radius.circular(10))),
      //             child: Column(
      //               children: [
      //                 Text(
      //                   "12",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //                 Text(
      //                   'Posts',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.all(4),
      //             decoration: BoxDecoration(
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Theme.of(context).primaryColor,
      //                     spreadRadius: 1,
      //                   ),
      //                 ],
      //                 color: Color(0xFFEBEDEF),
      //                 borderRadius: BorderRadius.all(Radius.circular(10))),
      //             child: Column(
      //               children: [
      //                 Text(
      //                   "10",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //                 Text(
      //                   'Blogs',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w500, fontSize: 18),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),

      //     Row(children: [
      //       Expanded(
      //         child: new Container(
      //             margin: const EdgeInsets.only(left: 10.0, right: 20.0),
      //             child: Divider(
      //               color: Colors.black,
      //             )),
      //       ),
      //       Text(
      //         "MY POSTS",
      //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      //       ),
      //       Expanded(
      //         child: new Container(
      //             margin: const EdgeInsets.only(left: 20.0, right: 10.0),
      //             child: Divider(
      //               color: Colors.black,
      //             )),
      //       ),
      //     ]),
      //     //Own Feed

      //     //End of feed section
      //   ],
      // ),
    );
  }
}
