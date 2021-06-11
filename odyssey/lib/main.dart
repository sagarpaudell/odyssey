import 'package:flutter/material.dart';
import 'package:odyssey/pages/auth_page.dart';
import './pages/auth_page.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './pages/feeds_page.dart';

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
  final pColors= const Color(0xFF6A1B4D);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Odyssey',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.amber,
            fontFamily: 'Montserrat',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mulish'),
                ),
          ),
          home: auth.isAuth ? FeedsPage() : AuthPage(),
          routes: {
            AuthPage.routeName: (ctx) => AuthPage(),
            FeedsPage.routeName: (ctx) => FeedsPage(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    // Provider.of<Auth>(context, listen: false)
    //     .getToken(username: 'dhgrfwhe', password: 'password');
    //     .signup('dhbsdrrh@mail.com', '3324237423', 'dhgrfwhe', 'password');
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
              //onPressed: () {},
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AuthPage())),
              child: Text(
                'Login',
              ))
        ],
      ),
    );
  }
}
