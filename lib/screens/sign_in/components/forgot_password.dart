import 'package:bookario/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: kSecondaryColor),
          ),
        )
      ],
    );
  }
}
