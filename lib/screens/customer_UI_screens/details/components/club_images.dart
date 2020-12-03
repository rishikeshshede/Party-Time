import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../components/size_config.dart';

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
      child: Hero(
        tag: widget.club.id.toString(),
        child: CarouselSlider.builder(
          itemCount: widget.club.images.length,
          itemBuilder: (BuildContext context, int itemIndex) => Container(
            child: Image.asset(widget.club.images[itemIndex]),
          ),
          options: CarouselOptions(
            height: 282.5,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            // onPageChanged: callbackFunction,
          ),
        ),
      ),
    );
  }
}
