import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Future<bool> resetEmailSent(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        title: Text(
          "An email to reset your password is sent to your email ID.",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: 17, color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              "Ok",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: kSecondaryColor),
            ),
            splashColor: Colors.red[50],
          ),
        ],
      );
    },
  );
}
