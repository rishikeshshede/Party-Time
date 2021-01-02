import 'package:bookario/components/rich_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class BookedEventCard extends StatelessWidget {
  const BookedEventCard({
    Key key,
    @required this.bookingData,
    // @required this.clubData,
  }) : super(key: key);

  final bookingData;
  // final clubData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: getProportionateScreenWidth(120),
      child: EachClubCard(bookingData: bookingData),
    );
  }
}

class EachClubCard extends StatelessWidget {
  const EachClubCard({
    Key key,
    @required this.bookingData,
    // this.clubData,
  }) : super(key: key);

  final bookingData;
  // final clubData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          color: Color(0xFFd6d6d6).withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: bookingData['name'],
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: getProportionateScreenWidth(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  children: [
                    // TextSpan(
                    //   text: '  (${clubData['location']})',
                    //   style: TextStyle(
                    //       fontSize: getProportionateScreenWidth(12),
                    //       fontWeight: FontWeight.normal),
                    // )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(
              //         "assets/icons/Location point.svg",
              //         height: getProportionateScreenWidth(13),
              //       ),
              //       const SizedBox(
              //         width: 3,
              //       ),
              //       Flexible(
              //         child: Container(
              //           child: Text(
              //             bookingData['address'],
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             maxLines: 1,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              RichTextRow(
                textLeft: "Booked on:  ",
                textRight: bookingData['date'],
              ),
              RichTextRow(
                textLeft: "Paid:  ",
                textRight: bookingData['bookingAmount'].toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
