import 'package:bookario/components/hoveringBackButton.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/size_config.dart';

import 'club_description.dart';
import 'club_images.dart';

class Body extends StatelessWidget {
  final event;

  const Body({Key key, @required this.event}) : super(key: key);

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
                    ClubImage(image: event['image'], eventId: event['eventId']),
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
                      EventDescription(
                        event: event,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      // TODO: Display remaining stags here
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
