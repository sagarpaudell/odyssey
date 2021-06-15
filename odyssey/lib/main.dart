import 'package:flutter/material.dart';
import 'package:odyssey/pages/auth_page.dart';
import './pages/auth_page.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './pages/feeds_page.dart';
import './pages/edit_profile_page.dart';

void main() {
  runApp(
    new MyApp(),
  );
}

Map<int, Color> color = {
  50: Color.fromRGBO(28, 46, 74, .1),
  100: Color.fromRGBO(28, 46, 74, .2),
  200: Color.fromRGBO(28, 46, 74, .3),
  300: Color.fromRGBO(28, 46, 74, .4),
  400: Color.fromRGBO(28, 46, 74, .5),
  500: Color.fromRGBO(28, 46, 74, .6),
  600: Color.fromRGBO(28, 46, 74, .7),
  700: Color.fromRGBO(28, 46, 74, .8),
  800: Color.fromRGBO(28, 46, 74, .9),
  900: Color.fromRGBO(28, 46, 74, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF1C2E4A, color);

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            primarySwatch: colorCustom,
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
            EditProfilePage.routeName: (ctx) => EditProfilePage(),
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
              )),
        ],
      ),
    );
  }
}
