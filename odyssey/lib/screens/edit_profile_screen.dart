import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:odyssey/screens/feeds_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/profile.dart';
import '../functions/error_dialog.dart';
import '../widgets/dp_input.dart';
import '../models/traveller.dart';
import 'dart:io';

enum Gender {
  male,
  female,
  others,
}
Gender gender;

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  PickedFile _pickedImage;
  final GlobalKey<FormState> _form = GlobalKey();
  final _lastNameFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  var _isLoading = false;
  final _genderFocusNode = FocusNode();

  var _profileTraveller = Traveller(
    username: '',
    firstname: '',
    lastname: '',
    profilePic: null,
    gender: '',
    country: '',
    city: '',
    travellerId: null,
  );

  Map _profileData = {
    'firstname': '',
    'lastname': '',
    'country': '',
    'city': '',
    'username': ''
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

  void _selectImage(PickedFile pickedImg) {
    _pickedImage = pickedImg;
  }

  Widget genderRadio(String title, Gender genderVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<Gender>(
          focusNode: _genderFocusNode,
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

  Future fbuilder;
  @override
  void initState() {
    fbuilder = getUserProfile();
    super.initState();
  }

  Future<void> getUserProfile() async {
    try {
      _profileTraveller =
          await Provider.of<Profile>(context, listen: false).getProfile();
      _profileData = {
        'firstname': _profileTraveller.firstname,
        'lastname': _profileTraveller.lastname,
        'country': _profileTraveller.country,
        'city': _profileTraveller.city,
        'username': _profileTraveller.username,
      };
      print(_profileData['firstname']);
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _cityFocusNode.dispose();
    _countryFocusNode.dispose();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select gender'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    // if (_pickedImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please pick an image'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }
    _form.currentState.save();
    if (_pickedImage != null) {
      _profileTraveller = Traveller(
        username: '',
        firstname: _profileData['firstname'],
        lastname: _profileData['lastname'],
        profilePic: _pickedImage,
        gender: genderText,
        country: _profileData['country'],
        city: _profileData['city'],
        travellerId: null,
      );
    }
    if (_pickedImage == null) {
      _profileTraveller = Traveller(
        username: '',
        firstname: _profileData['firstname'],
        lastname: _profileData['lastname'],
        gender: genderText,
        country: _profileData['country'],
        city: _profileData['city'],
        travellerId: null,
      );
    }
    setState(() {
      _isLoading = true;
      //print('$_isLoading form saved');
    });
    try {
      await Provider.of<Profile>(context, listen: false)
          .editProfile(_profileTraveller);
    } catch (e) {
      const errorMessage = 'Uhoh an error occured! Please try again later.';
      showErrorDialog(errorMessage, context);
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final authData = Provider.of<Auth>(context, listen: false);
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      //body:
      body: SafeArea(
        child: FutureBuilder<void>(
          future: fbuilder, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                      // height: deviceSize.height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Update your profile',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor.withOpacity(0.8), fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              // height: deviceSize.width * 0.31,

                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    _profileData['firstname'] == null &&
                                            _profileData['lastname'] == null
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start,
                                children: [
                                  DpInput(_selectImage),
                                  _profileData['firstname'] == null &&
                                          _profileData['lastname'] == null
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
                                                  fontWeight: FontWeight.bold,                                              fontSize: 30,
                                                    fontFamily: 'Lato'),
                                              ),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text('@'),
                                                Text(
                                                  _profileData['username'],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],

                              ),

                            ),
                            
                            Container(
                              
                              width: deviceSize.width,
                              child: Form(
                                key: _form,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: deviceSize.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 16, top: 22),
                                      child: TextFormField(
                                        initialValue: _profileData['firstname'],
                                        decoration:
                                            InputDecoration(labelText: 'First Name',
                                            enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF5F5F5),
                                        ),
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
                                    ),
                                    Container(
                                      height: deviceSize.height * 0.07,
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: TextFormField(
                                        initialValue: _profileData['lastname'],
                                        decoration:
                                            InputDecoration(labelText: 'Last Name',
                                            enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF5F5F5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        focusNode: _lastNameFocusNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_cityFocusNode);
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
                                    ),
                                    Container(
                                      height: deviceSize.height * 0.07,
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: TextFormField(
                                        initialValue: _profileData['city'],
                                        decoration:
                                            InputDecoration(labelText: 'City',
                                            enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF5F5F5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        focusNode: _cityFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_countryFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'City cannot be empty!';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _profileData['city'] = value;
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: deviceSize.height * 0.07,
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: TextFormField(
                                        initialValue: _profileData['country'],
                                        decoration:
                                            InputDecoration(labelText: 'Country',
                                            enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF5F5F5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        focusNode: _countryFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_genderFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Country cannot be empty!';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _profileData['country'] = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: deviceSize.height * 0.01,
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                      height: deviceSize.height * 0.02,
                                    ),
                            
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton.icon(
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
        ),
      ),
    );
  }
}
