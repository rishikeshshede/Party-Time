import 'dart:io';

import 'package:bookario/components/constants.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/home/components/add_club.dart';
import 'package:bookario/screens/club_UI_screens/home/components/own_clubs.dart';
import 'package:bookario/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/size_config.dart';

class ClubHomeScreen extends StatefulWidget {
  static String routeName = "/clubHome";

  @override
  _ClubHomeScreenState createState() => _ClubHomeScreenState();
}

class _ClubHomeScreenState extends State<ClubHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  File coverPhoto;
  bool hasClubs = false,
      homeLoading = true,
      loadMore = false,
      loadingMore = false;
  // clubAdded = false;
  int offset, limit;
  List<dynamic> clubData;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    this.checkAuthentification();
    getMyClubs();
    offset = 0;
    limit = 10;
    super.initState();
  }

  getMyClubs() async {
    String uid = await PersistenceHandler.getter('uid');
    print(uid);
    var response = await Networking.getData('clubs/get-club', {
      "userId": uid,
      "limit": limit.toString(),
      "offset": offset.toString(),
    });
    if (response['data'].length > 0) {
      setState(() {
        hasClubs = true;
        loadMore = true;
        loadingMore = false;
        clubData = response['data'];
      });
      // print(response);
    } else {
      setState(() {
        homeLoading = false;
        loadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              "assets/images/onlylogo.png",
              fit: BoxFit.cover,
            ),
          ),
          title: Text("Home"),
        ),
        body: hasClubs
            ? showClubs(context)
            : homeLoading
                ? Loading()
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Register your club by\nclicking on \'+\' button below.',
                      textAlign: TextAlign.center,
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            backgroundColor: kPrimaryLightColor,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewClub()),
              );
              // if (clubAdded && clubAdded != null) {
              getMyClubs();
              // clubAddedAlert(context);
              // }
            }));
  }

  SafeArea showClubs(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            OwnClubs(clubData: clubData),
            SizedBox(height: getProportionateScreenWidth(10)),
            loadMore
                ? loadingMore
                    ? Loading()
                    : FlatButton(
                        onPressed: () {
                          setState(() {
                            loadingMore = true;
                            offset += limit;
                          });
                          getMyClubs();
                        },
                        child: Text(
                          'load more',
                        ),
                        splashColor: Theme.of(context).primaryColorLight,
                      )
                : Container(),
            SizedBox(height: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }

  Future<bool> clubAddedAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "Club Added Successully",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
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
}
