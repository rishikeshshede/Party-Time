import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/size_config.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_string/random_string.dart';

class ReferAFriendTile extends StatefulWidget {
  @override
  _ReferAFriendTileState createState() => _ReferAFriendTileState();
}

class _ReferAFriendTileState extends State<ReferAFriendTile> {
  Future<bool> _generateReferralCode(BuildContext context) async {
    String referralCode = await PersistenceHandler.getter("referralCode");
    if (referralCode == null) {
      referralCode = randomAlphaNumeric(20);
      PersistenceHandler.setter("referralCode", referralCode);
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            'Your Referral code:',
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 0.7,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Send your friend this referral code to get discount in your next booking',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.7,
            ),
          ),
          actions: <Widget>[
            Container(
              width: SizeConfig.screenWidth,
              color: Colors.black12,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () async {
                        await FlutterClipboard.copy(referralCode);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.copy,
                          size: 22,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _generateReferralCode(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/refer.svg",
                  height: 17,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Refer a friend',
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
