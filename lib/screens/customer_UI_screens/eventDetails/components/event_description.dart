import 'package:bookario/screens/customer_UI_screens/details/components/description_text.dart';
import 'package:bookario/screens/club_UI_screens/eventDetails/components/eventBookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/constants.dart';
import '../../../../components/size_config.dart';

class EventDescription extends StatefulWidget {
  const EventDescription({
    Key key,
    @required this.event,
    this.pressOnSeeMore,
  }) : super(key: key);

  final event;
  final GestureTapCallback pressOnSeeMore;

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  // int time;
  // String amPm = 'Pm';
  // @override
  // void initState() {
  //   time = int.parse(widget.event['time']);
  //   if (time > 12) {
  //     setState(() {
  //       time -= 12;
  //     });
  //   } else {
  //     setState(() {
  //       amPm = 'Am';
  //     });
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.event['name'],
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventBookings(event: widget.event)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 20, top: 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SvgPicture.asset(
                  'assets/icons/booking.svg',
                  height: getProportionateScreenWidth(20),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(6),
          ),
          child: Text(
            widget.event['date'],
            style: TextStyle(color: Colors.white70),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/clock.svg",
                  height: getProportionateScreenWidth(14),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  // '${time.toString()} $amPm',
                  '${widget.event['time']}',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            // Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/icons/m-f.svg",
                  height: getProportionateScreenWidth(14),
                ),
                const SizedBox(
                  width: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: "Male : Female : ",
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: widget.event['mfRatio'].toString(),
                        // + " / " +
                        // event['femaleCount'].toString(),
                        style: TextStyle(color: kSecondaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Spacer(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        DescriptionTextWidget(text: widget.event['description']),
      ],
    );
  }
}
