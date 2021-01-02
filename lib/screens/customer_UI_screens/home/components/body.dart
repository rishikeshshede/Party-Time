import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';
import 'all_event_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            Events(),
            SizedBox(height: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
