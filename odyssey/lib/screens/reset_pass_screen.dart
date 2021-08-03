import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import './auth_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPassword extends StatefulWidget {
  final String uname;
  ResetPassword(this.uname);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formR = GlobalKey();

  final _confirmPassFNode = FocusNode();
  final _passController = TextEditingController();
  bool resetSuccess = false;
  bool _isLoading = false;

  Future<void> _saveForm() async {
    final isValid = _formR.currentState.validate();
    if (!isValid) {
      print('invalid');
      return;
    }
    _formR.currentState.save();

    try {
      resetSuccess = await Provider.of<Auth>(context, listen: false)
          .passwordReset(widget.uname, _passController.text);
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _confirmPassFNode.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formR,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(
                    "Reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: Text(
                    "Set a new password for your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _passController,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_confirmPassFNode),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Please Provide a value greater than 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    focusNode: _confirmPassFNode,
                    validator: (value) {
                      if (value != _passController.text) {
                        return 'Passwords do not match!';
                      }

                      return null;
                    },
                  ),
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.only(top: 14),
                        // height: (deviceSize.height - 200) * 0.10,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () async {
                            _isLoading = true;
                            await _saveForm();
                            if (resetSuccess) {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return _successPage(context);
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'The password couldn\'t be changed. Please try again'),
                                  backgroundColor: Theme.of(context).errorColor,
                                ),
                              );
                            }
                          },
                          child: Text('Reset password'),
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

_successPage(context) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                child: FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.green,
                  size: 50,
                )),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              margin: EdgeInsets.only(top: 2),
              alignment: Alignment.center,
              child: Text(
                "Success!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Text(
                "Your password reset process was successful. You can login with your new credentials now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false);
                  ;
                },
                child: Text('Login now'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
