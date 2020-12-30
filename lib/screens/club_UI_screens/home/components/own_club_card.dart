import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class OwnClubCard extends StatefulWidget {
  const OwnClubCard({
    Key key,
    @required this.club,
  }) : super(key: key);

  final club;

  @override
  _OwnClubCardState createState() => _OwnClubCardState();
}

class _OwnClubCardState extends State<OwnClubCard> {
  @override
  void initState() {
    PersistenceHandler.setter(
        "clubId ${widget.club['clubId']}", widget.club['clubId'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * .4,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          OwnClubDetailsScreen.routeName,
          arguments: ClubDetailsArguments(club: widget.club),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Container(
                      child: Hero(
                        tag: widget.club['clubId'].toString(),
                        child: Image.network(
                          widget.club['image'],
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
                            text: widget.club['name'],
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            children: [
                              TextSpan(
                                text: '  (${widget.club['location']})',
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
                                  widget.club['address'],
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
