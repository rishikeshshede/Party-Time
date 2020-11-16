import 'package:bookario/screens/customer_UI_screens/history/components/body.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BookingHistory extends StatelessWidget {
  static String routeName = "/history";
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
        title: Text("Booking History"),
      ),
      body: Body(),
    );
  }
}
