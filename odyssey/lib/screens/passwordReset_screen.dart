// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth.dart';

// class SecondStep extends StatefulWidget {
//   final String email;
//   final String uname;
//   SecondStep(this.email, this.uname);
//   @override
//   _SecondStepState createState() => _SecondStepState();
// }

// class _SecondStepState extends State<SecondStep> {
//   final _OTPController = TextEditingController();
//   bool _is_Loading = false;
//   bool allowReset = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             color: Colors.white,
//           ),
//           margin:
//               EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
//           alignment: Alignment.center,
//           height: MediaQuery.of(context).size.height * 0.5,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 margin: EdgeInsets.only(top: 20),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Verification",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Enter the verfication code sent to ${widget.email}:",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                 child: TextField(
//                   maxLength: 6,
//                   controller: _OTPController,
//                   textAlign: TextAlign.center,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     hintText: "Verification code",
//                   ),
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "This code will expire in ",
//                       style: TextStyle(
//                           color:
//                               Theme.of(context).primaryColor.withOpacity(0.7)),
//                     ),
//                     TweenAnimationBuilder(
//                       tween: Tween(begin: 300.0, end: 0.0),
//                       duration: Duration(seconds: 300),
//                       builder: (_, value, child) => Text(
//                         "00:${value.toInt()}",
//                         style:
//                             TextStyle(color: Colors.red[300].withOpacity(0.9)),
//                       ),
//                       onEnd: () => ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content:
//                               Text('The OTP has expired. Please resend OTP'),
//                           backgroundColor: Theme.of(context).errorColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _is_Loading
//                   ? CircularProgressIndicator()
//                   : Container(
//                       margin: EdgeInsets.only(top: 14),
//                       // height: (deviceSize.height - 200) * 0.10,
//                       width: MediaQuery.of(context).size.width * 0.5,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           setState(() => _is_Loading = true);
//                           allowReset =
//                               await Provider.of<Auth>(context, listen: false)
//                                   .passwordOTPVerify(
//                                       _OTPController.text, widget.uname);
//                           if (allowReset) {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return _successPage(context);
//                               },
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('The entered OTP is invalid'),
//                                 backgroundColor: Theme.of(context).errorColor,
//                               ),
//                             );
//                             setState(() => _is_Loading = false);
//                           }
//                         },
//                         child: Text('Verify'),
//                       ),
//                     ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Didn't receive code? ",
//                       style: TextStyle(
//                           color:
//                               Theme.of(context).primaryColor.withOpacity(0.7)),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushReplacement(
//                             SecondStep(widget.email, widget.uname));
//                       },
//                       child: Text(
//                         "Resend OTP Code",
//                         style:
//                             TextStyle(color: Colors.red[300].withOpacity(0.9)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// _finalStep(context) {
//   return Scaffold(
//     backgroundColor: Colors.transparent,
//     body: SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
//         alignment: Alignment.center,
//         height: MediaQuery.of(context).size.height * 0.5,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//               margin: EdgeInsets.only(top: 20),
//               alignment: Alignment.center,
//               child: Text(
//                 "Reset your password",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               alignment: Alignment.center,
//               child: Text(
//                 "Set a new password for your account",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.blueGrey,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//               child: TextField(
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Enter new password",
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 40,
//               ),
//               child: TextField(
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Confirm password",
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 14),
//               // height: (deviceSize.height - 200) * 0.10,
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: ElevatedButton(
//                 onPressed: () => showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return _successPage(context);
//                   },
//                 ),
//                 child: Text('Reset password'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// _successPage(context) {
//   return Scaffold(
//     backgroundColor: Colors.transparent,
//     body: SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
//         alignment: Alignment.center,
//         height: MediaQuery.of(context).size.height * 0.5,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Container(
//                 margin: EdgeInsets.only(top: 20),
//                 child: FaIcon(
//                   FontAwesomeIcons.checkCircle,
//                   color: Colors.green,
//                   size: 50,
//                 )),
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//               margin: EdgeInsets.only(top: 2),
//               alignment: Alignment.center,
//               child: Text(
//                 "Success!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               alignment: Alignment.center,
//               child: Text(
//                 "Your password reset process was successful. You can login with your new credentials now",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => AuthPage())),
//                 child: Text('Login now'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
