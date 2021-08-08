import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './auth_screen.dart';

class SessionScreen extends StatelessWidget {
  static const routeName = '/session';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Whoops! Your Session has expired',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Session has expired due to inactivity. No worries, simply login again',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(AuthPage.routeName),
                child: Text(
                  'Login',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
