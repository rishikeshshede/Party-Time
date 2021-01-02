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
    // WidgetsBinding.instance.removeObserver(this);

    //this method not called when user press android back button or quit
    print('dispose');
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
        title: Text("Premium Club"),
      ),
      body: Body(),
    );
  }
}
