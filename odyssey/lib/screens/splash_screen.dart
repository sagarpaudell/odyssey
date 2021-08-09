import 'package:flutter/material.dart';
import 'package:odyssey/screens/screens.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: AuthPage(),
      image: new Image.asset(
        './assets/images/logo1.png',
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.white,
      photoSize: 100.0,
    );
  }
}
