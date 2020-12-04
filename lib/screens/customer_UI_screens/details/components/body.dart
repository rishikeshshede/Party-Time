import 'package:bookario/components/hoveringBackButton.dart';
import 'package:bookario/models/Events.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/eventCard.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/components/size_config.dart';

import 'club_description.dart';
import 'club_images.dart';

class Body extends StatelessWidget {
  final Club club;

  const Body({Key key, @required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClubImages(club: club),
                    HoveringBackButton(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
                  padding: EdgeInsets.only(
                      top: getProportionateScreenWidth(15),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClubDescription(
                        club: club,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),

                      // TODO: Display remaining stags here

                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 6,
                            bottom: 12,
                          ),
                          child: Text(
                            "Upcoming events",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              demoClubs.length,
                              (index) {
                                return EventCard(
                                    event: demoEvents[index], index: index);
                              },
                            ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
