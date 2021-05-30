import 'package:flutter/material.dart';
import './login_page.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  Widget inputTextAreaWidget(String labelText, Function tapFunction) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
            )),
        controller: _passController,
        onSubmitted: (_) => {tapFunction},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 80,
            alignment: Alignment.center,
            child: Image.asset(
              './assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          inputTextAreaWidget(
            'E-mail',
            () {},
          ),
          inputTextAreaWidget(
            'Phone',
            () {},
          ),
          inputTextAreaWidget(
            'Username',
            () {},
          ),
          inputTextAreaWidget(
            'Password',
            () {},
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Sign Up',
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
              Text('Already have an account? '),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    LoginPage.routeName,
                  );
                },
                child: Text(
                  'Log In',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
