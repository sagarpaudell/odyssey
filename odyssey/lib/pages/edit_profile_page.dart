import 'package:flutter/material.dart';
import 'package:odyssey/pages/feeds_page.dart';
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

class EditProfilePage extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _pickedImage;
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

  // @override
  // void initState() {
  //   getUserProfile();
  //   super.initState();
  // }

  Future<void> getUserProfile() async {
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
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    _form.currentState.save();
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
    setState(() {
      _isLoading = true;
      //print('$_isLoading form saved');
    });
    try {
      await Provider.of<Profile>(context, listen: false)
          .editProfile(_profileTraveller);
      Navigator.of(context).pushReplacementNamed(FeedsPage.routeName);
    } catch (e) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
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
      body: FutureBuilder<void>(
        future:
            getUserProfile(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                    height: deviceSize.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Let\'s create a profile for you',
                              style: TextStyle(
                                  color: Color(0XFF8B8B8B), fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: deviceSize.height * 0.2,
                            width: deviceSize.width * 0.8,
                            child: Row(
                              mainAxisAlignment:
                                  _profileData['firstname'] == null &&
                                          _profileData['lastname'] == null
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.spaceBetween,
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
                                                  fontSize: 30,
                                                  fontFamily: 'Lato'),
                                            ),
                                          ),
                                          subtitle: Text(
                                            _profileData['username'],
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
                                    initialValue: _profileData['firstname'],
                                    decoration:
                                        InputDecoration(labelText: 'Firstname'),
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
                                    initialValue: _profileData['lastname'],
                                    decoration:
                                        InputDecoration(labelText: 'Lastname'),
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
                                  TextFormField(
                                    initialValue: _profileData['city'],
                                    decoration:
                                        InputDecoration(labelText: 'City'),
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
                                  TextFormField(
                                    initialValue: _profileData['country'],
                                    decoration:
                                        InputDecoration(labelText: 'Country'),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceSize.height * 0.05,
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
    );
  }
}
