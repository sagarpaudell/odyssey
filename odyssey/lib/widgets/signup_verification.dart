import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:odyssey/screens/auth_screen.dart';
import 'package:odyssey/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class SignupVerification extends StatefulWidget {
  static const routeName = '/emailverifypage';

  @override
  _SignupVerificationState createState() => _SignupVerificationState();
}

class _SignupVerificationState extends State<SignupVerification> {
  Future fbuilder;
  String email;
  final _OTPController = TextEditingController();
  bool emailVerified = false;
  bool _isLoading = false;
  @override
  void initState() {
    fbuilder = send();
    super.initState();
  }

  Future<void> send() async {
    await Provider.of<Auth>(context, listen: false).sendOTP(false);
  }

  @override
  void dispose() {
    _OTPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = Provider.of<Auth>(context).userProfileInfo['email'];
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "Verify your Email",
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
                  "A code has been sent to your email address: $email. Enter the verification code here:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                child: TextField(
                  controller: _OTPController,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Verification code",
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "This code will expire in ",
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7)),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 300.0, end: 0.0),
                      duration: Duration(seconds: 300),
                      builder: (_, value, child) => Text(
                        "00:${value.toInt()}",
                        style:
                            TextStyle(color: Colors.red[300].withOpacity(0.9)),
                      ),
                      onEnd: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('The OTP has expired. Please resend OTP'),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  ],
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
                          setState(() => _isLoading = true);
                          emailVerified =
                              await Provider.of<Auth>(context, listen: false)
                                  .emailOTPVerify(_OTPController.text);
                          if (emailVerified) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _successPage(context);
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('The entered OTP is invalid'),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            );
                            setState(() => _isLoading = false);
                          }
                        },
                        //showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return _successPage(context);
                        //   },
                        // ),
                        child: Text('Verify'),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code? ",
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignupVerification.routeName);
                      },
                      child: Text(
                        "Resend OTP Code",
                        style:
                            TextStyle(color: Colors.red[300].withOpacity(0.9)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                "Thank You. \n You have successfully verified your Email.",
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
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => MainScreen())),
                child: Text('Go to my HomePage'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
