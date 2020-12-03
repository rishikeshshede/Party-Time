import 'package:bookario/models/Events.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/constants.dart';
import '../../../../components/size_config.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key key,
    @required this.event,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Event event;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.eventName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(6),
          ),
          child: Text(
            event.date,
            style: TextStyle(color: Colors.black87),
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  event.time,
                  maxLines: 3,
                ),
              ],
            ),
            Spacer(),
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
                    text: "Male / Female : ",
                    style: TextStyle(color: kPrimaryColor),
                    children: [
                      TextSpan(
                        text: event.male.toString() +
                            " / " +
                            event.female.toString(),
                        style: TextStyle(color: kSecondaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        DescriptionTextWidget(text: event.description),
      ],
    );
  }
}
