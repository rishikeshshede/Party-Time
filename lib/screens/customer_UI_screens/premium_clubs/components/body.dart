import 'package:bookario/screens/customer_UI_screens/premium_clubs/components/all_premium_club_list.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            PremiumEvents(),
            SizedBox(height: getProportionateScreenWidth(6)),
          ],
        ),
      ),
    );
  }
}
