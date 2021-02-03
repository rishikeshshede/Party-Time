import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class PremiumClubsList extends StatefulWidget {
  static String routeName = "/premiumClubs";

  @override
  _PremiumClubsListState createState() => _PremiumClubsListState();
}

class _PremiumClubsListState extends State<PremiumClubsList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/onlylogo.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text("Premiun Events"),
      ),
      body: Body(),
    );
  }
}
