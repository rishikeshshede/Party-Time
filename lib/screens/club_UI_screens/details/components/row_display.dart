import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class RowDisplay extends StatelessWidget {
  const RowDisplay({
    Key key,
    @required this.title,
    @required this.value,
    this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          height: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(color: kSecondaryColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
