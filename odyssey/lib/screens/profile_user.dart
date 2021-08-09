import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile.dart';
import '../widgets/profile_container.dart';
import '../widgets/post_container.dart';
import './main_screen.dart';

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
      print('this is buddhe data $friendProfileData');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
