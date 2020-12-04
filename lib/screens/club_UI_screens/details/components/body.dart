import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/constants.dart';
import 'package:bookario/models/Events.dart';
import 'package:bookario/screens/club_UI_screens/details/components/club_description.dart';
import 'package:bookario/screens/club_UI_screens/details/components/custom_app_bar.dart';
import 'package:bookario/screens/club_UI_screens/details/components/eventCard.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/components/size_config.dart';

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
                CustomAppBar(title: club.clubName, location: club.location),
                ClubDescription(club: club),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 6,
                            bottom: 18,
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
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white70,
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.15,
                  bottom: getProportionateScreenWidth(10),
                  top: getProportionateScreenWidth(2),
                ),
                child: DefaultButton(
                  text: "Add Event",
                  press: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
