import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:odyssey/providers/auth.dart';
import 'package:odyssey/providers/profile.dart';
import 'package:odyssey/screens/screens.dart';

import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

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
        ),
        ChangeNotifierProxyProvider<Auth, Profile>(
          create: (ctx) => Profile(),
          update: (ctx, auth, traveller) => Profile(auth.userName, auth.userId,
              auth.token, traveller == null ? null : traveller.travellerUser),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
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
            // scaffoldBackgroundColor: Color(0xfff0f2f5),
            scaffoldBackgroundColor: Colors.white,
          ),

          // home: auth.isAuth ? MainScreen() : EditProfileScreen(),
          home: MainScreen(),
          routes: {
            AuthPage.routeName: (ctx) => AuthPage(),
            FeedsScreen.routeName: (ctx) => FeedsScreen(),
            EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
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
