import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';

import '../../../../size_config.dart';

class ClubImages extends StatefulWidget {
  const ClubImages({
    Key key,
    @required this.club,
  }) : super(key: key);

  final Club club;

  @override
  _ClubImagesState createState() => _ClubImagesState();
}

class _ClubImagesState extends State<ClubImages> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * .3,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(widget.club.images[currentImage]),
      ),
    );
  }
}
