import 'package:flutter/material.dart';
import '../widgets/auth_card.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      // ),
      body: AuthCard(),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       child: Image.asset(
      //         './assets/images/logo.png',
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     Column(
      //       children: [
      //         Container(
      //           margin: EdgeInsets.symmetric(
      //             horizontal: 15,
      //           ),
      //           padding: EdgeInsets.all(10),
      //           child: TextField(
      //             decoration:
      //                 InputDecoration(labelText: 'Email or Phone Number'),
      //             controller: _userNameController,
      //             onSubmitted: (_) {},
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(
      //             horizontal: 15,
      //           ),
      //           padding: EdgeInsets.all(10),
      //           child: TextField(
      //             decoration: InputDecoration(
      //                 labelText: 'Password',
      //                 contentPadding: EdgeInsets.symmetric(
      //                   horizontal: 20,
      //                 )),
      //             controller: _passController,
      //             onSubmitted: (_) => {},
      //           ),
      //         ),
      //       ],
      //     ),
      //     TextButton(
      //       onPressed: () {},
      //       child: Text(
      //         'Forgot Password',
      //       ),
      //     ),
      //     SizedBox(
      //       height: 5,
      //     ),
      //     ElevatedButton(
      //       onPressed: () {},
      //       child: Text(
      //         'Login',
      //       ),
      //     ),
      //     Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         Container(
      //           padding: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               border: Border.all(
      //                 color: Theme.of(context).primaryColor,
      //                 style: BorderStyle.solid,
      //               )),
      //           child: Text(
      //             'OR',
      //           ),
      //         ),
      //         SizedBox(
      //           height: 7,
      //         ),
      //         Divider(
      //           thickness: 1,
      //           color: Colors.black,
      //         ),
      //       ],
      //     ),
      //     ElevatedButton(
      //       onPressed: () {},
      //       child: Text(
      //         'Continue with Facebook',
      //       ),
      //     ),
      //     SizedBox(
      //       height: 15,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('Don\'t have an account? '),
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pushNamed(
      //               RegisterPage.routeName,
      //             );
      //           },
      //           child: Text(
      //             'Sign Up!',
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
