import 'package:bookario/components/rich_text_row.dart';
import 'package:bookario/models/History.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../size_config.dart';

class BookedClubCard extends StatelessWidget {
  const BookedClubCard({
    Key key,
    @required this.club,
  }) : super(key: key);

  final History club;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: getProportionateScreenWidth(120),
      child: EachClubCard(club: club),
    );
  }
}

class EachClubCard extends StatelessWidget {
  const EachClubCard({
    Key key,
    @required this.club,
  }) : super(key: key);

  final History club;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          color: Color(0xFFd6d6d6).withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: club.clubName,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: getProportionateScreenWidth(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  children: [
                    TextSpan(
                      text: '  (${club.location})',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Location point.svg",
                      height: getProportionateScreenWidth(13),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          club.address,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RichTextRow(
                club: club,
                textLeft: "Booked on:  ",
                textRight: club.bookingDate,
              ),
              RichTextRow(
                club: club,
                textLeft: "Paid:  ",
                textRight: club.amountPaid.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
