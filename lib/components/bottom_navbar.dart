import 'dart:io';

import 'package:bookario/constants.dart';
import 'package:bookario/screens/history/booking_history.dart';
import 'package:bookario/screens/home/home_screen.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:bookario/size_config.dart';
import 'package:flutter/material.dart';

class BottomCustomNavBar extends StatefulWidget {
  static String routeName = "/navbar";
  @override
  _BottomCustomNavBarState createState() => _BottomCustomNavBarState();
}

class _BottomCustomNavBarState extends State<BottomCustomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SignInScreen(),
    BookingHistory()
  ];
  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: Text(
            "Want to exit?",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
            FlatButton(
              onPressed: () => exit(0),
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: kSecondaryColor,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Premium Clubs',
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Bookings')
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
