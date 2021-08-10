import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:odyssey/screens/feeds_screen.dart';
import 'package:odyssey/screens/profile_self.dart';
import 'package:odyssey/screens/screens.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/profile.dart';
import '../functions/error_dialog.dart';
import '../widgets/dp_input.dart';
import '../models/traveller.dart';

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
  File _pickedImage;
  final GlobalKey<FormState> _form = GlobalKey();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  var _isLoading = false;
  bool firstLogin = false;
  bool goHome = false;
  bool appbarLoading = true;
  final _genderFocusNode = FocusNode();
  Map<String, dynamic> profileData;
  var _profileTraveller = Traveller(
    firstname: '',
    lastname: '',
    phone: '',
    profilePic: null,
    gender: '',
    country: '',
    city: '',
    travellerId: null,
  );

  Map _profileData = {
    'firstname': '',
    'lastname': '',
    'phone': '',
    'country': '',
    'profilePicUrl': '',
    'city': '',
    'username': '',
    'gender': '',
  };

  String get genderText {
    switch (gender) {
      case Gender.male:
        return 'MALE';
        break;
      case Gender.female:
        return 'FEMALE';
        break;
      case Gender.others:
        return 'OTHERS';
        break;
      default:
        return 'Unknown';
    }
  }

  Gender get genderEnum {
    switch (_profileData['gender']) {
      case 'MALE':
        return Gender.male;
        break;

      case 'FEMALE':
        return Gender.female;
        break;
      case 'OTHERS':
        return Gender.others;
        break;
      default:
        return Gender.others;
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
          focusNode: _genderFocusNode,
          value: genderVal,
          groupValue: gender,
          autofocus: genderVal == genderEnum ? true : false,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (Gender value) {
            setState(() {
              gender = value;
              print(genderText);
              print(genderEnum);
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
        'username': _profileTraveller.username,
        'phone': _profileTraveller.phone,
        'profilePicUrl': _profileTraveller.profilePicUrl,
        'country': _profileTraveller.country,
        'city': _profileTraveller.city,
        'gender': _profileTraveller.gender,
      };
      if (_profileData['firstname'] == '') {
        firstLogin = true;
      }
      setState(() {
        appbarLoading = false;
      });
      print(firstLogin);
    } catch (error) {
      print(error);
    }
  }

  Future<bool> successDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Voila!'),
            content: firstLogin
                ? Text('Congrats! Profile Created successfully.')
                : Text('Profile updated successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                  if (firstLogin) {
                    setState(() {
                      goHome = true;
                    });
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _cityFocusNode.dispose();
    _phoneFocusNode.dispose();
    _countryFocusNode.dispose();
    _genderFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
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
    if (firstLogin) {
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please pick an image'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        return;
      }
    }
    _form.currentState.save();
    if (_pickedImage != null) {
      _profileTraveller = Traveller(
        firstname: _profileData['firstname'],
        lastname: _profileData['lastname'],
        profilePic: _pickedImage,
        gender: genderText,
        phone: _profileData['phone'],
        country: _profileData['country'],
        city: _profileData['city'],
        travellerId: null,
      );
    }
    if (_pickedImage == null) {
      _profileTraveller = Traveller(
        firstname: _profileData['firstname'],
        lastname: _profileData['lastname'],
        gender: genderText,
        phone: _profileData['phone'],
        profilePic: null,
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
      successDialog(context);
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
    // _profileTraveller =
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: appbarLoading
            ? SizedBox(
                height: 0,
                width: 0,
              )
            : firstLogin
                ? SizedBox(
                    height: 0,
                    width: 0,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
        title: Text(
          appbarLoading
              ? ''
              : firstLogin
                  ? 'Let\'s create a profile for you'
                  : 'Update your profile',
          style: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),

      //body:
      body: FutureBuilder<void>(
        future: fbuilder, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                    // height: deviceSize.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment:
                                  firstLogin && _profileData['lastname'] == ''
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                              children: [
                                DpInput(_selectImage,
                                    _profileData['profilePicUrl']),
                                firstLogin && _profileData['lastname'] == ''
                                    ? SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                                    : Container(
                                        width: deviceSize.width * 0.35,
                                        child: ListTile(
                                          title: FittedBox(
                                            child: Text(
                                              //'${profileData['first_name']} ${profileData['last_name']}',
                                              '${_profileData['firstname']} ${_profileData['lastname']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
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
                                    margin:
                                        EdgeInsets.only(bottom: 16, top: 22),
                                    child: TextFormField(
                                      initialValue: _profileData['firstname'],
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
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
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
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
                                            .requestFocus(_phoneFocusNode);
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
                                      initialValue: _profileData['phone'],
                                      decoration: InputDecoration(
                                        labelText: 'Phone',
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
                                      keyboardType: TextInputType.number,
                                      focusNode: _phoneFocusNode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_cityFocusNode);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Phone number cannot be empty!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _profileData['phone'] = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: deviceSize.height * 0.07,
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: TextFormField(
                                      initialValue: _profileData['city'],
                                      decoration: InputDecoration(
                                        labelText: 'City',
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
                                      decoration: InputDecoration(
                                        labelText: 'Country',
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
                          !goHome
                              ? _isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton.icon(
                                      onPressed: _saveForm,
                                      icon: Icon(Icons.done),
                                      label: Text(
                                        'Update Profile',
                                      ),
                                    )
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        MainScreen.routeName);
                                  },
                                  icon: Icon(Icons.home),
                                  label: Text(
                                    'Start Surfing',
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
