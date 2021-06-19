import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}



class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
              fontSize: 18,
            ),
            ),
          ],
        )
      ,
      ),

    );
  }
}