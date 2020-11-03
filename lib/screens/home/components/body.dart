import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'home_header.dart';
import 'all_club_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            HomeHeader(),
            divider(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Clubs(),
            SizedBox(height: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
