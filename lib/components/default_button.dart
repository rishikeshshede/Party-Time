import 'package:flutter/material.dart';

import 'constants.dart';
import 'size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.7,
      height: SizeConfig.orientation == Orientation.portrait
          ? SizeConfig.screenHeight * .07
          : SizeConfig.screenHeight * .1,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: kSecondaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: SizeConfig.orientation == Orientation.portrait
                  ? SizeConfig.screenHeight * .03
                  : SizeConfig.screenHeight * .05,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
