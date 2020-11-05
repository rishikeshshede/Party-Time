import 'package:bookario/screens/history/components/body.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class BookingHistory extends StatelessWidget {
  static String routeName = "/history";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
