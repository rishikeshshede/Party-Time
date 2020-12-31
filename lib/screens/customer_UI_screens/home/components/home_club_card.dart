import 'package:bookario/screens/customer_UI_screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class HomeClubCard extends StatelessWidget {
  const HomeClubCard({
    Key key,
    @required this.eventData,
  }) : super(key: key);

  final eventData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * .96,
      height: getProportionateScreenWidth(200),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ClubDetailsArguments(event: eventData),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
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
                      tag: eventData['eventId'].toString(),
                      child: Image.network(
                        eventData['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.96,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 5),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: eventData['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                              children: [
                                TextSpan(
                                  text: '  (${eventData['location']})',
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
                                    eventData['address'],
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
