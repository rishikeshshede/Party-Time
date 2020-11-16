import 'package:bookario/models/Clubs.dart';
import 'package:bookario/screens/club_UI_screens/home/components/own_club_card.dart';
import 'package:bookario/size_config.dart';
import 'package:flutter/material.dart';

class OwnClubs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              demoClubs.length,
              (index) {
                return OwnClubCard(club: demoClubs[index]);
              },
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
