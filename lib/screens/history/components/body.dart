import 'package:bookario/screens/history/components/booked_club_card.dart';
import 'package:bookario/components/home_header.dart';
import 'package:bookario/models/History.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(5)),
            HomeHeader(
              title: "Booking History",
            ),
            divider(),
            SizedBox(height: getProportionateScreenWidth(10)),
            SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    clubsBooked.length,
                    (index) {
                      return BookedClubCard(club: clubsBooked[index]);
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
