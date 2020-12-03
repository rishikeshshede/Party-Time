import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoveringBackButton extends StatelessWidget {
  const HoveringBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(left: 12, top: 16),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white54),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/icons/Back Icon.svg',
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
