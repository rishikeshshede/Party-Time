import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'constants.dart';

class ChangeOnboardingScreenText extends StatelessWidget {
  const ChangeOnboardingScreenText({
    Key key,
    this.textFirst,
    this.clickableText,
    this.onPressed,
  }) : super(key: key);

  final String textFirst, clickableText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: textFirst,
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          TextSpan(
            text: clickableText,
            style: TextStyle(color: kSecondaryColor),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
