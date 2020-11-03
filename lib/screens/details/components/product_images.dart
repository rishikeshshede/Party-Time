import 'package:flutter/material.dart';
import 'package:bookario/models/Product.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.club,
  }) : super(key: key);

  final Club club;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.club.id.toString(),
              child: CarouselSlider.builder(
                itemCount: widget.club.images.length,
                itemBuilder: (BuildContext context, int itemIndex) => Container(
                  child: Image.asset(widget.club.images[itemIndex]),
                ),
                options: CarouselOptions(
                  height: 300,
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
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(
        //     widget.club.images.length,
        //     (index) => buildDot(index: index),
        //   ),
        // )
      ],
    );
  }

  // AnimatedContainer buildDot({int index}) {
  //   return AnimatedContainer(
  //     duration: kAnimationDuration,
  //     margin: EdgeInsets.only(right: 5),
  //     height: 6,
  //     width: currentImage == index ? 20 : 6,
  //     decoration: BoxDecoration(
  //       color: currentImage == index ? kSecondaryColor : Color(0xFFD8D8D8),
  //       borderRadius: BorderRadius.circular(3),
  //     ),
  //   );
  // }
}
