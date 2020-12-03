import 'package:bookario/screens/customer_UI_screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class HomeClubCard extends StatelessWidget {
  const HomeClubCard({
    Key key,
    @required this.club,
  }) : super(key: key);

  final Club club;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .95,
      height: getProportionateScreenWidth(170),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ClubDetailsArguments(club: club),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF343434).withOpacity(0.3),
                          Color(0xFF343434).withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Hero(
                      tag: club.id.toString(),
                      child: Image.asset(
                        club.images[0],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.95,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF343434).withOpacity(0.8),
                            Color(0xFF343434).withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              club.clubName,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
