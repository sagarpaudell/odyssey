import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // Size deviceSize = MediaQuery.of(context).size;
  Color bgColor = Color(0xffe8edea);

  _messageBuilder(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //Others message
          Row(                                      
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage('./assets/images/guptaji.jpg'),
                  ),
            ),
              Container(
                width:MediaQuery.of(context).size.width*0.55,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.white70,
                borderRadius: BorderRadius.circular(30)
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("hello  jfeqhj hwhe uhj dwhfuh jdhbpkjh bwdpfhp kdwjfbh pkdwfjh dpfkjhb pkjdbwh kpj",
                    style: TextStyle(color: Theme.of(context).primaryColor,
                    fontSize: 15),
                    ),
                    SizedBox(height: 8,),
                    Text('2021/12/20', style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11
                    ),
                    )
                  ],
                )
              ),
            ],
          ),

          //User's  sent message
          Container(
            margin: EdgeInsets.only(top: 16, right: 8),
            width:MediaQuery.of(context).size.width*0.55,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30)
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("hello  jfeqhj hwhe uhj dwhfuh jdhbpkjh bwdpfhp kdwjfbh pkdwfjh dpfkjhb pkjdbwh kpj",
                style: TextStyle(color: Colors.white,
                fontSize: 15),
                ),
                SizedBox(height: 8,),
                Text('2021/12/20', style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11
                ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [PopupMenuButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert,
            size: 28,
            ),
          ),
          itemBuilder:(BuildContext context)=>[
            PopupMenuItem(child: Row(
              children: [
                Icon(Icons.account_circle, color: Theme.of(context).primaryColor,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("View Profile", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                  ),),
              ],
            ),
            ),
            PopupMenuItem(child: Row(
              children: [
                Icon(Icons.block_flipped, color: Theme.of(context).primaryColor,),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Block this user", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                  ),),
              ],
            ),
            ),
            PopupMenuItem(child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red[400],),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Delete conversation", style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.w600),
                  ),),
              ],
            ),
            ),
            

          ]
          ),
        ],
        automaticallyImplyLeading: false,      
        title:
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios), 
            ),
            
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('./assets/images/guptaji.jpg'),                               
                ),           
              ),
            ),
            Text('Deependra Gupta',
            style:        
            TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            ),
          ],
        ),

      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
              ),
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext contect, int nothing){
                  return _messageBuilder();

                }),
            ),
          ),
        ],
      ),

    );
  }
}