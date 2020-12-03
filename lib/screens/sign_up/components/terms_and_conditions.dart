import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../components/constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "By continuing your confirm that you agree \nwith our ",
        style: Theme.of(context).textTheme.caption,
        children: [
          TextSpan(
            text: "Term and Condition",
            style: TextStyle(color: kSecondaryColor),
            recognizer: TapGestureRecognizer()..onTap = () {},
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
