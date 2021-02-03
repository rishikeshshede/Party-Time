import 'dart:io';

import 'package:bookario/components/constants.dart';
import 'package:bookario/screens/customer_UI_screens/home/customer_home_screen.dart';
import 'package:bookario/screens/customer_UI_screens/premium_clubs/premium_club_list.dart';
import 'package:bookario/screens/customer_UI_screens/profile/profile_screen.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

class BottomCustomNavBar extends StatefulWidget {
  static String routeName = "/navbar";
  @override
  _BottomCustomNavBarState createState() => _BottomCustomNavBarState();
}

class _BottomCustomNavBarState extends State<BottomCustomNavBar>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    PremiumClubsList(),
    ProfileScreen()
  ];

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "Want to exit?",
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
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
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        body: PageView(
            onPageChanged: onPageChanged,
            controller: _pageController,
            children: _children),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF141414),
          unselectedItemColor: Colors.grey,
          fixedColor: kSecondaryColor,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Premium Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: kAnimationDuration,
      curve: Curves.ease,
    );
  }

  void onPageChanged(int value) {
    setState(() {
      this._currentIndex = value;
    });
  }
}
