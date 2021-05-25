import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Image.asset(
              './assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration:
                      InputDecoration(labelText: 'Email or Phone Number'),
                  controller: _userNameController,
                  onSubmitted: (_) {},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                      )),
                  controller: _passController,
                  onSubmitted: (_) => {},
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Login',
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
              Text('Don\'t have an account? '),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign Up!',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
