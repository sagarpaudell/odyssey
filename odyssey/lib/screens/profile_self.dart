import 'package:flutter/material.dart';

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
          
        ],
        title:Icon(Icons.arrow_back_ios, color:Theme.of(context).primaryColor,),
        
      ),

    );
  }
}