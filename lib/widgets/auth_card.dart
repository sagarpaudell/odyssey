import 'package:flutter/material.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  // final _emailController = TextEditingController();

  // final _phoneController = TextEditingController();

  // final _userNameController = TextEditingController();

  // final _passController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _confirmPassFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  var _isLoading = false;

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'phone': '',
    'username': '',
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

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   final _phoneFocusNode.dispose();
  //   final _userNameFocusNode.dispose();
  //   final _passFocusNode.dispose();
  //   final _confirmPassFocusNode.dispose();
  //   super.dispose();
  // }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return _isLoading
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Form(
              key: _form,
              child: Container(
                height: deviceSize.height,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: _authMode == AuthMode.Signup ? 80 : 200,
                      alignment: Alignment.center,
                      child: Image.asset(
                        './assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    _authMode == AuthMode.Signup
                        ? Container(
                            height: (deviceSize.height - 80) * 0.6,
                            padding: EdgeInsets.all(20),
                            child: ListView(children: [
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'E-mail'),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneFocusNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Phone'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _phoneFocusNode,
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(_userNameFocusNode),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 7) {
                                    return 'Number too short';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['phone'] = value;
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'UserName'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: _userNameFocusNode,
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(_passFocusNode),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Provide a value';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['username'] = value;
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                controller: _passwordController,
                                focusNode: _passFocusNode,
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(_confirmPassFocusNode),
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
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password'),
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                focusNode: _confirmPassFocusNode,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }

                                  return null;
                                },
                                onSaved: (_) {
                                  _saveForm();
                                },
                              ),
                            ]),
                          )
                        : Container(
                            height: (deviceSize.height - 80) * 0.4,
                            padding: EdgeInsets.all(20),
                            child: ListView(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'E-mail or Phone'),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_phoneFocusNode);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || !value.contains('@')) {
                                      return 'Invalid email!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _authData['email'] = value;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Password'),
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  focusNode: _confirmPassFocusNode,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Passwords is empty';
                                    }

                                    return null;
                                  },
                                  onSaved: (_) {
                                    _saveForm();
                                  },
                                ),
                              ],
                            ),
                          ),
                    //login form,
                    ElevatedButton(
                      onPressed: () {
                        _saveForm();
                      },
                      child: Text(
                        _authMode == AuthMode.Signup ? 'Sign Up' : 'Login',
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                              )),
                          child: Text(
                            'OR',
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Continue with Facebook',
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                            _authMode == AuthMode.Signup ? 'Log In' : 'Sign Up',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
