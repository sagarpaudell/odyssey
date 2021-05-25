import 'package:flutter/material.dart';
import './pages/splash_page.dart';
import './pages/login_page.dart';

void main() {
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odyssey',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mulish'),
            ),
      ),
      home: MyHomePage(),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Odyssey',
        ),
      ),
      body: Column(
        children: [
          new Center(
            child: new Text(
              'Helloooo!',
            ),
          ),
          TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => LoginPage())),
              child: Text(
                'Login',
              ))
        ],
      ),
    );
  }
}
