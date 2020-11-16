import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SpinKitRipple(
            color: kPrimaryColor,
            size: 60,
          ),
        ),
        Text("Please wait...")
      ],
    );
  }
}
