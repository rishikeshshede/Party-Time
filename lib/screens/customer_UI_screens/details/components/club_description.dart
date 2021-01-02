import 'package:bookario/screens/customer_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key key,
    @required this.event,
    this.clubData,
  }) : super(key: key);

  final event;
  final clubData;
  // final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event['name'],
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(5),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Location point.svg",
                height: getProportionateScreenWidth(15),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: SelectableText(
                    clubData['address'],
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/clock.svg",
              height: getProportionateScreenWidth(14),
            ),
            Text(
              ' ${event['time']}',
            ),
          ],
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Flexible(
        //       child: Container(
        //         child: Text(
        //           "Directions",
        //           style: TextStyle(
        //             color: kSecondaryColor,
        //             decoration: TextDecoration.underline,
        //           ),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 5,
        //     ),
        //     SvgPicture.asset(
        //       "assets/icons/directions.svg",
        //       height: getProportionateScreenWidth(12),
        //       color: kSecondaryColor,
        //     ),
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "About the event",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        DescriptionTextWidget(text: event['description']),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "Availabe Passes:",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        AllPrices(priceDescription: event['priceDescription']),
      ],
    );
  }
}
