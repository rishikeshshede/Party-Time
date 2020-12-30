import 'package:bookario/screens/club_UI_screens/details/components/eventCard.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

class ClubEvents extends StatelessWidget {
  final List<dynamic> eventData;
  const ClubEvents({Key key, @required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              eventData.length,
              (index) {
                return EventCard(event: eventData[index]);
              },
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
          ],
        ),
      ),
    );
  }
}
