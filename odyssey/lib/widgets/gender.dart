import 'package:flutter/material.dart';

class GenderSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          color: Color(0xFF3B4257),
          child: Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            margin: new EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shop,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  '_gender.name',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )),
    );
  }
}
