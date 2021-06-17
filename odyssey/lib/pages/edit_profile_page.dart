import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/dp_input.dart';
import 'dart:io';

enum gender {
  male,
  female,
  rather_not_say,
}

class EditProfilePage extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _pickedImage;
  final GlobalKey<FormState> _form = GlobalKey();
  final _lastNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();

  Map<String, String> _profileData = {
    'firstname': '',
    'lastname': '',
    'address': '',
    'gender': '',
  };
  void _selectImage(File pickedImg) {
    _pickedImage = pickedImg;
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _addressFocusNode.dispose();
    _genderFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      print('svsfvs');
      return;
    }
    _form.currentState.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          height: deviceSize * 0.8,
          child: Column(
            children: [
              Text(
                'Let\'s create a profile for you',
                style: TextStyle(
                  color: Colors.amber,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: _profileData['firstname'].isEmpty &&
                        _profileData['lastname'].isEmpty
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  DpInput(_selectImage),
                  _profileData['firstname'].isEmpty &&
                          _profileData['lastname'].isEmpty
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Container(
                          width: 200,
                          child: ListTile(
                            title: FittedBox(
                              child: Text(
                                '${_profileData['firstname']} ${_profileData['lastname']}',
                                style:
                                    TextStyle(fontSize: 30, fontFamily: 'Lato'),
                              ),
                            ),
                            subtitle: Text(
                              authData.userName,
                            ),
                          ),
                        ),
                ],
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Firstname'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Firstname cannot be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _profileData['firstname'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Lastname'),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      focusNode: _lastNameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addressFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lastname cannot be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _profileData['lastname'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      keyboardType: TextInputType.text,
                      focusNode: _addressFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_genderFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Address cannot be empty!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _profileData['address'] = value;
                      },
                    ),

                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'Gender'),
                    //   keyboardType: TextInputType.,
                    //   textInputAction: TextInputAction.next,
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context).requestFocus(_lastNameFocusNode);
                    //   },
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Name cannot be empty!';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     _profileData['firstname'] = value;
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: Icon(Icons.done),
                label: Text(
                  'Update Profile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
