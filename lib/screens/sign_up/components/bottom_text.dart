import 'package:bookario/components/change_onboarding_screen.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:bookario/screens/sign_up/components/terms_and_conditions.dart';
import 'package:flutter/material.dart';

import '../../../components/size_config.dart';

class SignupScreenBottomText extends StatelessWidget {
  const SignupScreenBottomText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        ChangeOnboardingScreenText(
          textFirst: "Already have an account? ",
          clickableText: "Sign In",
          onPressed: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        TermsAndConditions(),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }
}
