import 'package:flutter/material.dart';
import 'package:odyssey/models/models.dart';
import 'package:odyssey/data/data.dart';
import 'package:odyssey/widgets/post_container.dart';


class SelfProfile extends StatefulWidget {
  @override
  _SelfProfileState createState() => _SelfProfileState();
}

class _SelfProfileState extends State<SelfProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.white,
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
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.mode_edit,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // PopupMenuItem(
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.block_flipped,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 8),
                    //         child: Text(
                    //           "Block this user",
                    //           style: TextStyle(
                    //               color: Theme.of(context).primaryColor,
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 0.3,
                            color: Theme.of(context).primaryColor,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Delete account",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
        ],
        title:Icon(Icons.arrow_back_ios, color:Theme.of(context).primaryColor,),
        
      ),
      body: Column(children: [
        Container(
          child: Row(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width-20) * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top:10),
                  child: CircleAvatar(
                    
                      radius: 52,
                      backgroundImage: AssetImage('./assets/images/samesh.jpg'),
                      
                      
                    ),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width-20) * 0.7,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
            
                  children: [
                  Text("Samesh Bajracharya",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600 ),),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Kathmandu, Nepal",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400 ),),
                  OutlinedButton(onPressed: (){

                  },
                  child: Text("Edit Profile"),
                  style: OutlinedButton.styleFrom(
                    primary:Theme.of(context).primaryColor,
                    
                  ),
                  )
                  
                ],
                ),
              )

            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          decoration: BoxDecoration(
            boxShadow:[BoxShadow(
                color:Color(0xFFEBEDEF),
              blurRadius: 30,
              spreadRadius: 2,
              ),
              ],
            color:Color(0xFFEBEDEF),            
            borderRadius: BorderRadius.all(Radius.circular(10))),
          width: MediaQuery.of(context).size.width-20,
          margin: EdgeInsets.fromLTRB(10, 16, 10, 16),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text("120", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                Text('Places Visited', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              ],
              ),
              
              Column(children: [
                Text("12.1k", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                Text('Followers', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              ],
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                color:Color(0xFFAEB6BF ),            
                borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(children: [
                      Text("12", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      Text('Posts', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                    ],
                    ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                color:Color(0xFFAEB6BF ),            
                borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(children: [
                    Text("10", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                    Text('Blogs', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                  ],
                  ),
              ),
              
              
                            
            ],
          ),
        ),

        Row(children:[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                        )),
                  ),
                  Text("MY POSTS", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                        )),
                  ),
                ]),
        //Own Feed
      //   CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //       (context, index) {
      //         final Post post = posts[index];
      //         return PostContainer(post: post);
      //       },
      //       childCount: posts.length,
      //     ),
      //     )
      //   ],
      // ),
      


      //End of feed section

      ],
      ),

    );
  }
}