import 'package:bookario/screens/customer_UI_screens/history/components/body.dart';
import 'package:flutter/material.dart';

import '../../../components/size_config.dart';

class BookingHistory extends StatelessWidget {
  static String routeName = "/history";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Booking History"),
      ),
      body: Body(),
    );
  }
}
