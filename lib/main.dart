import 'package:efficacy_user/pages/club_details.dart';
import 'package:efficacy_user/pages/event_screen.dart';
import 'package:efficacy_user/pages/explore_screen.dart';
import 'package:efficacy_user/pages/feed_screen.dart';
import 'package:efficacy_user/pages/homescreen.dart';
import 'package:efficacy_user/provider/event_provider.dart';
import 'package:efficacy_user/themes/efficacy_theme.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_user/pages/google_sign_in.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
=======
import 'package:efficacy_user/pages/subscription_page.dart';
>>>>>>> d27990e66b309a340abdaeb378c5656ebe96e018

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<EventProvider>.value(value: EventProvider())
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            home: snapshot.connectionState != ConnectionState.done
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.orangeAccent,
                  )
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapShot) {
                      if (userSnapShot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          backgroundColor: Colors.orangeAccent,
                        );
                      }
                      if (userSnapShot.hasData) {
                        return const HomeScreen();
                      }
                      return const SignIn();
                    },
                  ),
            routes: <String, WidgetBuilder>{
              HomeScreen.route: (BuildContext context) => const HomeScreen(),
              EventScreen.route: (BuildContext context) => const EventScreen(),
              ClubDetail.route: (BuildContext context) => const ClubDetail(),
              ExploreScreen.route: (BuildContext context) =>
                  const ExploreScreen(),
              FeedScreen.route: (BuildContext context) => const FeedScreen(),
              SignIn.route: (BuildContext context) => const SignIn(),
            },
          ),
        );
      },
    );
  }
}
