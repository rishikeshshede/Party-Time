import 'package:bookario/screens/club_UI_screens/eventDetails/eventDetails.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.event,
  }) : super(key: key);

  final event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: getProportionateScreenWidth(80),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event)),
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
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        event['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      flex: 8,
                      child: Text(
                        event['name'] + '\n' + event['date']
                        // + '\t' +
                        // event['eventTime']
                        ,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold,
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
