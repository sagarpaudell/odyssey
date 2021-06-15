import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/dp_input.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _pickedImage;

  void _selectImage(File pickedImg) {
    _pickedImage = pickedImg;
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      height: deviceSize,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DpInput(_selectImage),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.grey),
              //   ),
              //   margin: EdgeInsets.all(15),
              //   height: deviceSize * 0.20,
              //   width: 200,
              //   child: Image.asset(
              //     './assets/images/logo1.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Text(
                authData.userName,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          TextFormField(),
          TextFormField(),
          TextFormField(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.done),
            label: Text(
              'Update Profile',
            ),
          ),
        ],
      ),
    ));
  }
}
