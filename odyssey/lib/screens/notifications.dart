import 'package:flutter/material.dart';
import 'dart:io';

class Notifications extends StatefulWidget {
  
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(14),
                          child: Text(
                            "Notifications",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.all(14),
                    child: Text("mark all as read",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),))
                ],
              ),
              Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(color: Colors.black,
                          ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(                    
                            radius: 18,
                            backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text("Biraj adhikari liked your photo", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text("2 min ago",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(                    
                            radius: 18,
                            backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text("Biraj adhikari liked your photo bla bla cha skljh alsh lkj hsvlkj ", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Text("2021/3/17",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                  ),
                ],
              ),
            ],
          ),
                
        ),
      ),
    );
  }
}