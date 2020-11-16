import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final String location;

  CustomAppBar({@required this.title, @required this.location});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            ActionButton(
              icon: "assets/icons/Back Icon.svg",
              press: Navigator.of(context).pop,
            ),
            Spacer(),
            TitleandLocation(title: title, location: location),
            Spacer(),
            ActionButton(
              icon: "assets/icons/edit.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TitleandLocation extends StatelessWidget {
  const TitleandLocation({
    Key key,
    @required this.title,
    @required this.location,
  }) : super(key: key);

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          location,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);
  final String icon;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: SvgPicture.asset(
          icon,
          height: 18,
        ),
      ),
    );
  }
}
