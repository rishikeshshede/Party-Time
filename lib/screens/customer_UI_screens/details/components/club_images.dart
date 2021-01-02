import 'package:flutter/material.dart';

class ClubImage extends StatefulWidget {
  const ClubImage({
    Key key,
    @required this.image,
    this.eventId,
  }) : super(key: key);

  final String image;
  final int eventId;

  @override
  _ClubImageState createState() => _ClubImageState();
}

class _ClubImageState extends State<ClubImage> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Hero(
        tag: widget.eventId.toString(),
        child: Container(
          child: Image.network(widget.image),
        ),
        // child: CarouselSlider.builder(
        //   itemCount: 1,
        //   itemBuilder: (BuildContext context, int itemIndex) => Container(
        //     child: Image.network(widget.image),
        //   ),
        //   options: CarouselOptions(
        //     height: 282.5,
        //     aspectRatio: 16 / 9,
        //     viewportFraction: 1,
        //     initialPage: 0,
        //     enableInfiniteScroll: true,
        //     reverse: false,
        //     autoPlay: true,
        //     autoPlayInterval: Duration(seconds: 3),
        //     autoPlayAnimationDuration: Duration(milliseconds: 800),
        //     autoPlayCurve: Curves.fastOutSlowIn,
        //     enlargeCenterPage: false,
        //     scrollDirection: Axis.horizontal,
        //     // onPageChanged: callbackFunction,
        //   ),
        // ),
      ),
    );
  }
}
