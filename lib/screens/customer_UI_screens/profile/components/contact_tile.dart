import 'package:bookario/screens/customer_UI_screens/profile/components/help_and_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    Key key,
  }) : super(key: key);

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpAndSupportScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/gmail.svg",
                  height: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Help & Support',
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(
                "assets/icons/arrow_right.svg",
                height: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
