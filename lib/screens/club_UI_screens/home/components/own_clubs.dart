import 'package:bookario/screens/club_UI_screens/home/components/own_club_card.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

class OwnClubs extends StatelessWidget {
  final List<dynamic> clubData;
  const OwnClubs({Key key, @required this.clubData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              clubData.length,
              (index) {
                return OwnClubCard(club: clubData[index]);
              },
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
