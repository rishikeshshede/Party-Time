import 'package:bookario/components/bottom_navbar.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/home/club_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookario/routes.dart';
import 'package:bookario/screens/splash/splash_screen.dart';
import 'package:bookario/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final User user = FirebaseAuth.instance.currentUser;
  String userType;

  void getUserType() async {
    userType = await PersistenceHandler.getter("userType");
    setState(() {
      userType = userType;
    });
  }

  @override
  void initState() {
    getUserType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookario',
      theme: theme(),
      home: (user == null)
          ? SplashScreen()
          : (userType == 'customer' ? BottomCustomNavBar() : ClubHomeScreen()),
      routes: routes,
    );
  }
}
