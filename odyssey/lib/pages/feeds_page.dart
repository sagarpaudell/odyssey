import 'package:flutter/material.dart';
import './edit_profile_page.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class FeedsPage extends StatelessWidget {
  static const routeName = '/feeds';
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                'Feeds ${authData.userName}',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(EditProfilePage.routeName),
                child: Text('add profile'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
