import 'package:flutter/material.dart';
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  
  @override
  Widget build(BuildContext context) { 
    const choices=['blockuser', 'logout'];
      
    showAlertDialog(BuildContext context) {     
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
          child: Text("Cancel"),
          onPressed:  () {},
          ),
          TextButton(
          child: Text("Log Out", style: TextStyle(
          color: Colors.red[400],
          ),),
          onPressed:  () {},
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

  void choiceAction(String choice){
    if(choice =='blockuser'){
     print('Block');
    }
    else if(choice == 'logout'){
    showAlertDialog(context);
    }
  }

  iconValue(choice){
     if(choice=='blockuser'){
       return Icons.block_flipped;
     }
     else if (choice=='logout'){
       return Icons.logout;
     }
  }

  textValue(choice){
     if(choice=='blockuser'){
       return 'Block this user';
     }
     else if (choice=='logout'){
       return 'Log Out';
     }
  }


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.white,
        actions:[
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
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                        children: [
                          Icon(
                            iconValue(choice),
                            color:  choice=='logout'?Colors.red[400]: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              textValue(choice),
                              style: TextStyle(
                                  color: choice=='logout'?Colors.red[400]: Theme.of(context).primaryColor,
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
                  Row(
                    
                    children: [
                      Container(
                        height: 28,
                        margin: EdgeInsets.only(top:6),
                        child: ElevatedButton(onPressed: (){
                          
                        },
                        style:ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                        ),
                        child: Text("Follow"),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(right: 10, top:6),
                      child: IconButton(onPressed: (){

                      },
                      icon: Icon(Icons.message),
                      iconSize: 20,        
                      ),
                    ),                 
                    ],
                  ),                 
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
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                color:Color(0xFFEBEDEF),            
                
                ),
                    child: Column(children: [
                        Text("120", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                        Text('Places Visited', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      ],
                      ),
              ),
              
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                color:Color(0xFFEBEDEF),            
                
                ),
                    child: Column(children: [
                      Text("12.1k", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      Text('Followers', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                    ],
                    ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  boxShadow:[BoxShadow(
                    color:Theme.of(context).primaryColor,
                    spreadRadius: 1,
                  ),
              ],
              color:Color(0xFFEBEDEF),            
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
                  boxShadow:[BoxShadow(
                    color:Theme.of(context).primaryColor,
                    spreadRadius: 1,
                  ),
              ],
              color:Color(0xFFEBEDEF),             
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
                  Text("POSTS", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                        )),
                  ),
                ]),
        //Own Feed
      //   




      


      //End of feed section

      ],
      ),

    );
  }
}