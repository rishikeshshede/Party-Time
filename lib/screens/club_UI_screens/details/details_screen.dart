import 'package:bookario/models/Clubs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class OwnClubDetailsScreen extends StatelessWidget {
  static String routeName = "/ownClubDetails";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leading: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 18),
      //     child: SvgPicture.asset(
      //       "assets/icons/Back Icon.svg",
      //     ),
      //   ),
      // ),
      body: Body(club: agrs.club),
    );
  }
}

class ClubDetailsArguments {
  final Club club;

  ClubDetailsArguments({@required this.club});
}
