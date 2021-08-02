import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile.dart';
import '../screens/profile_user.dart';

class FoFo extends StatefulWidget {
  final bool followingList;
  final String usernameInQues;

  FoFo(this.followingList, this.usernameInQues);

  @override
  _FoFoState createState() => _FoFoState();
}

class _FoFoState extends State<FoFo> {
  List<dynamic> listData;
  Future fbuilder;

  @override
  void initState() {
    if (widget.followingList) {
      fbuilder = getselfFollowingList();
    } else {
      fbuilder = getselfFollowerList();
    }
    super.initState();
  }

  Future<void> getselfFollowerList() async {
    listData =
        await Provider.of<Profile>(context, listen: false).getSelfFollowers();
  }

  Future<void> getselfFollowingList() async {
    listData =
        await Provider.of<Profile>(context, listen: false).getSelfFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.25),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  hoverColor: Theme.of(context).primaryColor,
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(Icons.close_outlined),
                                ),
                                Text(
                                  widget.followingList
                                      ? "Following"
                                      : "Followers",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (ctx, index) => Card(
                                elevation: 0.6,
                                shadowColor: Colors.grey,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserProfile(
                                            listData[index]['username']),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          listData[index]['photo_main']),
                                    ),
                                    title: Text(
                                      '${listData[index]['first_name']} ${listData[index]['last_name']}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: listData.length,
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: CircleAvatar(
                            //         radius: 20,
                            //         backgroundImage: NetworkImage(
                            //             'https://www.woolha.com/media/2020/03/eevee.png'),
                            //       ),
                            //     ),
                            //     Text(
                            //       "Deependra Gupta",
                            //       style: TextStyle(
                            //           fontSize: 18, fontWeight: FontWeight.w500),
                            //     )
                            //   ],
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
