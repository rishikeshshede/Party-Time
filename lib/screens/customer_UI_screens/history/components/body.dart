import 'package:bookario/models/History.dart';
import 'package:bookario/screens/customer_UI_screens/history/components/booked_club_card.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(5)),
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
      ),
    );
  }
}
