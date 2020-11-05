import 'package:bookario/components/change_onboarding_screen.dart';
import 'package:bookario/screens/sign_up/components/terms_and_conditions.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookario/constants.dart';
import 'package:bookario/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Register Account", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                SignUpForm(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
