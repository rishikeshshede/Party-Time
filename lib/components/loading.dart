import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'constants.dart';

class Loading extends StatelessWidget {
  final String text;
  const Loading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SpinKitRipple(
            color: kPrimaryColor,
            size: 60,
          ),
        ),
        Text(
          text == null ? "Please wait..." : text,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
