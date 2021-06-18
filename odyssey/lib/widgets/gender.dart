import 'package:flutter/material.dart';

class GenderSelect extends StatelessWidget {
  final String gender;
  GenderSelect(this.gender);
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.10,
      //idth: double.infinity,
      child: Card(
          color: Color(0xFF3B4257),
          child: Container(
            height: deviceSize.height * 0.08,
            alignment: Alignment.center,
            margin: new EdgeInsets.all(5.0),
            width: deviceSize.width * 0.40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shop,
                  color: Colors.white,
                  size: 40,
                ),
                Text(
                  gender,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          )),
    );
  }
}
