import 'package:flutter/material.dart';

class FeedsPage extends StatelessWidget {
  static const routeName = '/feeds';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Feeds',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
