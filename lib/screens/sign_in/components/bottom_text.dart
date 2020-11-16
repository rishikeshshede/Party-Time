import 'package:bookario/components/change_onboarding_screen.dart';
import 'package:bookario/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SigninScreenBottomText extends StatelessWidget {
  const SigninScreenBottomText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        ChangeOnboardingScreenText(
          textFirst: "Don't have an account? ",
          clickableText: "Sign Up",
          onPressed: () {
            Navigator.pushNamed(context, SignUpScreen.routeName);
          },
        ),
      ],
    );
  }
}
