import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odyssey/providers/chat.dart';
import 'package:odyssey/providers/auth.dart';
import 'package:odyssey/providers/profile.dart';
import 'package:odyssey/providers/posts.dart';
import 'package:odyssey/widgets/signup_verification.dart';
import './screens/profile_self.dart';
import './screens/profile_user.dart';
import './screens/screens.dart';
import './screens/bookmarks.dart';
import './screens/splash_screen.dart';
import './screens/single_blog_screen.dart';
import './widgets/fb_loading.dart';
import './providers/blog.dart';
import './providers/search.dart';
import './screens/session_expired_screen.dart';
import './screens/notifications.dart';
import './providers/notification.dart' as noti;
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

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
  // bool _isLoading = false;

  // bool tryAuto;
  // bool persisted;

  // Future<void> checkAutoLogin(BuildContext context) async {
  //   try {
  //     persisted =
  //         await Provider.of<Auth>(context, listen: false).checkDataPersist();
  //     if (persisted) {
  //       tryAuto =
  //           await Provider.of<Auth>(context, listen: false).tryAutoLogin();
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

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
        ),
        ChangeNotifierProxyProvider<Auth, Chat>(
          create: (ctx) => Chat(),
          update: (ctx, auth, _) => Chat(
            auth.userName,
            auth.userId,
            auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Posts>(
          create: (ctx) => Posts(),
          update: (ctx, auth, _) => Posts(
            auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Blog>(
          create: (ctx) => Blog(),
          update: (ctx, auth, _) => Blog(
            auth.userName,
            auth.userId,
            auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, noti.Notification>(
          create: (ctx) => noti.Notification(),
          update: (ctx, auth, _) => noti.Notification(
            auth.userId,
            auth.token,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Search>(
          create: (ctx) => Search(),
          update: (ctx, auth, _) => Search(
            auth.userId,
            auth.token,
          ),
        ),
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
          // home: FutureBuilder(
          //   future: checkAutoLogin(context),
          //   builder: (ctx, authResultSnapshot) =>
          //       authResultSnapshot.connectionState == ConnectionState.waiting
          //           ? SplashPage()
          //           : auth.isAuth
          //               ? auth.email_verifed
          //                   ? MainScreen()
          //                   : SignupVerification()
          //               : persisted
          //                   ? tryAuto
          //                       ? SplashPage()
          //                       : SessionScreen()
          //                   : AuthPage(),
          // ),

          //                  FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashPage() : SessionScreen(): auth.isAuth
          // ? auth.email_verifed
          //     ? MainScreen()
          //     : SignupVerification()
          // : auth.dataPersisted
          //     ? FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashPage()
          //                 : SessionScreen(),
          //       )
          //     : AuthPage(),
          //home: SessionScreen(),
          home: auth.isAuth
              ? auth.email_verifed
                  ? MainScreen()
                  : SignupVerification()
              : FutureBuilder(
                  future: Future.wait([
                    auth.checkDataPersist(),
                    auth.tryAutoLogin(),
                  ]),
                  builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashPage()
                          : snapshot.data[0]
                              ? snapshot.data[1]
                                  ? SplashPage()
                                  : SessionScreen()
                              : AuthPage()),

          routes: {
            MainScreen.routeName: (ctx) => MainScreen(),
            SessionScreen.routeName: (ctx) => SessionScreen(),
            AuthPage.routeName: (ctx) => AuthPage(),
            FeedsScreen.routeName: (ctx) => FeedsScreen(),
            EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
            ChatScreen.routeName: (ctx) => ChatScreen(),
            SelfProfile.routeName: (ctx) => SelfProfile(),
            Bookmark.routeName: (ctx) => Bookmark(),
            Notifications.routeName: (ctx) => Notifications(),
            SignupVerification.routeName: (ctx) => SignupVerification(),
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
