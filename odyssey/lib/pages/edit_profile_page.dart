import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/dp_input.dart';
import 'dart:io';

enum Gender {
  male,
  female,
  others,
}
Gender gender;

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

  String get genderText {
    switch (gender) {
      case Gender.male:
        return 'male';
        break;
      case Gender.female:
        return 'female';
        break;
      case Gender.others:
        return 'others';
        break;
      default:
        return 'Unknown';
    }
  }

  void _selectImage(File pickedImg) {
    _pickedImage = pickedImg;
  }

  Widget genderRadio(String title, Gender genderVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<Gender>(
          value: genderVal,
          groupValue: gender,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (Gender value) {
            setState(() {
              gender = value;
              print(genderText);
            });
          },
        ),
        Text(
          title,
          maxLines: 1,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
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
    if (gender == null) {
      print('Null gender');
      return;
    }
    _profileData['gender'] = genderText;

    _form.currentState.save();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Let\'s create a profile for you',
                style: TextStyle(
                  color: Colors.amber,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: deviceSize.height * 0.2,
                width: deviceSize.width * 0.8,
                child: Row(
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
                            width: deviceSize.width * 0.35,
                            child: ListTile(
                              title: FittedBox(
                                child: Text(
                                  '${_profileData['firstname']} ${_profileData['lastname']}',
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Lato'),
                                ),
                              ),
                              subtitle: Text(
                                authData.userName,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: deviceSize.height * 0.55,
                width: deviceSize.width,
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Firstname'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode);
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
                          FocusScope.of(context)
                              .requestFocus(_addressFocusNode);
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
                      SizedBox(
                        height: deviceSize.height * 0.05,
                      ),
                      Text(
                        'Gender *',
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: <Widget>[
                          genderRadio('Male', Gender.male),
                          genderRadio('Female', Gender.female),
                          genderRadio('Others', Gender.others),
                        ],
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     genderRadio('Male', Gender.male),
                      //     genderRadio('Female', Gender.female),
                      //     genderRadio('Others', Gender.others),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: deviceSize.height * 0.05,
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
