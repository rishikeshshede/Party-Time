import 'package:bookario/models/Events.dart';
import 'package:bookario/screens/club_UI_screens/eventDetails/eventDetails.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.event,
    this.index,
  }) : super(key: key);

  final Event event;
  final index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: getProportionateScreenWidth(80),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailsScreen(eventId: event.id)),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: SizeConfig.screenWidth * 0.96,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF343434).withOpacity(0.8),
                      Color(0xFF343434).withOpacity(0.4),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      event.images[0],
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        event.eventName + '\n' + event.date,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
