import 'package:bookario/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class PremiumClubsList extends StatefulWidget {
  static String routeName = "/premiumClubs";

  @override
  _PremiumClubsListState createState() => _PremiumClubsListState();
}

class _PremiumClubsListState extends State<PremiumClubsList> {
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
        title: Text("Premium Club"),
      ),
      body: Body(),
    );
  }
}
