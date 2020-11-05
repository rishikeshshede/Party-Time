import 'package:bookario/models/History.dart';
import 'package:bookario/size_config.dart';
import 'package:flutter/material.dart';

class RichTextRow extends StatelessWidget {
  const RichTextRow({
    Key key,
    @required this.club,
    @required this.textLeft,
    @required this.textRight,
  }) : super(key: key);

  final History club;
  final String textLeft, textRight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          text: textLeft,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
          children: [
            TextSpan(
              text: textRight,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
