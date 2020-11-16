import 'package:bookario/screens/club_UI_screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../size_config.dart';

class OwnClubCard extends StatelessWidget {
  const OwnClubCard({
    Key key,
    @required this.club,
  }) : super(key: key);

  final Club club;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: SizeConfig.screenHeight * .4,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          OwnClubDetailsScreen.routeName,
          arguments: ClubDetailsArguments(club: club),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Container(
                      child: Hero(
                        tag: club.id.toString(),
                        child: Image.asset(
                          // club.images[0],
                          "assets/images/dummyPub1.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 2, 12, 5),
                    color: Colors.black.withOpacity(.8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: club.clubName,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            children: [
                              TextSpan(
                                text: '  (${club.location})',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
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
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
