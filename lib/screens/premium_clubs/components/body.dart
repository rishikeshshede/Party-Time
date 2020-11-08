import 'package:bookario/screens/premium_clubs/components/all_premium_club_list.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            HomeHeader(
              title: "Premium Clubs",
            ),
            divider(),
            SizedBox(height: getProportionateScreenWidth(10)),
            PremiumClubs(),
            SizedBox(height: getProportionateScreenWidth(6)),
          ],
        ),
      ),
    );
  }
}
