import 'package:flutter/material.dart';

class ShowAlert {
  // static showToast(String message) {
  //   print(message);
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 2,
  //     backgroundColor: kPrimaryColor,
  //     textColor: Colors.black,
  //     fontSize: 15.0,
  //   );
  // }
  static showAlert(BuildContext context, String errormessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(errormessage),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      },
    );
  }
}
