import 'package:flutter/material.dart';
// import 'package:odyssey/pages/auth_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:odyssey/screens/screens.dart';
import 'package:odyssey/widgets/forgot_password.dart';
import 'package:odyssey/widgets/signup_verification.dart';
// import '../pages/feeds_page.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  // final _emailController = TextEditingController();

  // final _phoneController = TextEditingController();

  // final _userNameController = TextEditingController();

  // final _passController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  // final _phoneFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _confirmPassFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  bool rememberMe = true;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'userName': '',
    'password': '',
  };
  Map<String, dynamic> signupResponse = {
    'email': '',
    'userName': '',
    'password': '',
  };
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _showErrorDialog(String errorText) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Oops! An error occured'),
              content: Text(
                errorText,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'Okay',
                  ),
                )
              ],
            ));
  }

  @override
  void dispose() {
    //_phoneFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passFocusNode.dispose();
    _confirmPassFocusNode.dispose();
    super.dispose();
  }

  //_saveForm() {}
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      print('invalid');
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
      //print('$_isLoading form saved');
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['userName'],
          _authData['password'],
          rememberMe,
        );
      } else {
        print('siging up');
        // Sign user up
        signupResponse = await Provider.of<Auth>(context, listen: false).signup(
            _authData['email'], _authData['userName'], _authData['password']);

        if (signupResponse.containsKey('success')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account Created Successfully'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
        } else if (signupResponse.containsKey('email')) {
          _showErrorDialog('The entered email is already used');
        } else {
          _showErrorDialog('The entered username is already used');
        }
      }
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      print(errorMessage);
      // if (error.toString().contains('Invalid Username')) {
      //   errorMessage = 'Enter a valid email address.';
      // } else if (error.toString().contains('username')) {
      //   errorMessage = 'A user with that username already exists.';
      // }
      _showErrorDialog(errorMessage);
    }
    // } on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    //     errorMessage = 'Could not find a user with that email.';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Invalid password.';
    //   }
    //   _showErrorDialog(errorMessage);
    catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    // print('logged in');
    //_showErrorDialog('Logged in Succesfully');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Stack(
            children: [
              Opacity(
                opacity: _isLoading ? 0.5 : 1,
                child: Container(
                  height: deviceSize.height,
                  child: ListView(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        margin: _authMode == AuthMode.Signup
                            ? EdgeInsets.only(top: 12)
                            : EdgeInsets.only(top: 40),
                        height: _authMode == AuthMode.Signup ? 150 : 200,
                        alignment: Alignment.center,
                        child: Image.asset(
                          './assets/images/logo1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      _authMode == AuthMode.Signup
                          ? Container(
                              height: (deviceSize.height - 80) * 0.45,
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: ListView(children: [
                                Container(
                                  height: deviceSize.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'E-mail',
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
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_userNameFocusNode);
                                    },
                                    validator: (value) {
                                      // if (value.isEmpty || !value.contains('@')) {
                                      //   return 'Invalid email!';
                                      // }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['email'] = value;
                                    },
                                  ),
                                ),
                                // Container(
                                //   height: deviceSize.height * 0.07,
                                //   margin: EdgeInsets.only(bottom: 14),
                                //   child: TextFormField(
                                //     decoration: InputDecoration(
                                //       hintText: 'Phone',
                                //       enabledBorder: OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(10),
                                //         ),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(10),
                                //         ),
                                //       ),
                                //       filled: true,
                                //       fillColor: Color(0xffF5F5F5),
                                //       prefixIcon: Icon(Icons.phone),
                                //     ),
                                //     textInputAction: TextInputAction.next,
                                //     keyboardType: TextInputType.number,
                                //     focusNode: _phoneFocusNode,
                                //     onFieldSubmitted: (_) =>
                                //         FocusScope.of(context)
                                //             .requestFocus(_userNameFocusNode),
                                //     validator: (value) {
                                //       if (value.isEmpty || value.length < 7) {
                                //         return 'Number too short';
                                //       }
                                //       if (double.tryParse(value) == null) {
                                //         return 'Please enter a valid number.';
                                //       }
                                //       if (double.parse(value) <= 0) {
                                //         return 'Please enter a number greater than zero.';
                                //       }

                                //       return null;
                                //     },
                                //     onSaved: (value) {
                                //       _authData['phone'] = value;
                                //     },
                                //   ),
                                // ),
                                Container(
                                  height: deviceSize.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'UserName',
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
                                      prefixIcon: Icon(Icons.account_circle),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    focusNode: _userNameFocusNode,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context)
                                            .requestFocus(_passFocusNode),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Provide a value';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['userName'] = value;
                                    },
                                  ),
                                ),
                                Container(
                                  height: deviceSize.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Password',
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
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    obscureText: true,
                                    controller: _passwordController,
                                    focusNode: _passFocusNode,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).requestFocus(
                                            _confirmPassFocusNode),
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 6) {
                                        return 'Please Provide a value greater than 6 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['password'] = value;
                                    },
                                  ),
                                ),
                                Container(
                                  height: deviceSize.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
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
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    focusNode: _confirmPassFocusNode,
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match!';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                            )
                          : Container(
                              height: (deviceSize.height - 200) * 0.40,
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: ListView(
                                children: [
                                  Container(
                                    height: deviceSize.height * 0.08,
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Username',
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
                                        prefixIcon: Icon(Icons.account_circle),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).requestFocus(
                                            _confirmPassFocusNode);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Username cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _authData['userName'] = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: deviceSize.height * 0.08,
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Password',
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
                                        prefixIcon: Icon(Icons.lock),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      focusNode: _confirmPassFocusNode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Password is empty';
                                        }

                                        return null;
                                      },
                                      onSaved: (value) {
                                        _authData['password'] = value;
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: rememberMe,
                                          onChanged: (_) {
                                            print('object $_');
                                            setState(() {
                                              rememberMe = !rememberMe;
                                            });
                                          }),
                                      Text('Remember me'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                      _authMode == AuthMode.Login
                          ? Container(
                              height: (deviceSize.height - 200) * 0.10,
                              margin: EdgeInsets.only(right: 20, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    //
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return ForgotPassword();
                                      },
                                    ),
                                    child: Text("Forgot password?"),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ), //if signup, nothing

                      Container(
                        height: _authMode == AuthMode.Signup
                            ? (deviceSize.height - 80) * 0.08
                            : (deviceSize.height - 200) * 0.10,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: ElevatedButton(
                          onPressed: _saveForm,
                          child: Text(
                            _authMode == AuthMode.Signup ? 'Sign Up' : 'Login',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),

                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Colors.black,
                              )),
                        ),
                        Text("OR"),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                              )),
                        ),
                      ]),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 30, right: 30),
                      //   child: OutlinedButton(
                      //     onPressed: () {},
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(
                      //           FontAwesomeIcons.facebook,
                      //           color: Colors.blue,
                      //         ),
                      //         SizedBox(
                      //           width: 8,
                      //         ),
                      //         Text(
                      //           'Continue with Facebook',
                      //           style: TextStyle(color: Colors.blue),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_authMode == AuthMode.Signup
                              ? 'Already have an account? '
                              : 'Don\'t have an account? '),
                          TextButton(
                            onPressed: () => _switchAuthMode(),
                            child: Text(
                              _authMode == AuthMode.Signup
                                  ? 'Log In'
                                  : 'Sign Up',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: _isLoading ? 1 : 0,
                child: Container(
                  height: deviceSize.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
