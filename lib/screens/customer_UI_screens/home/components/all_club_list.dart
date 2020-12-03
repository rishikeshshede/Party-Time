import 'package:bookario/components/section_title.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/screens/customer_UI_screens/home/components/home_club_card.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
          child: SectionTitle(title: "Clubs in Pune", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                demoClubs.length,
                (index) {
                  return HomeClubCard(club: demoClubs[index]);
                },
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
            ],
          ),
        )
      ],
    );
  }
}
