import 'package:bookario/size_config.dart';
import 'package:flutter/material.dart';

class HomeClubCard extends StatelessWidget {
  const HomeClubCard({
    Key key,
    @required this.clubName,
    @required this.address,
    @required this.image,
    @required this.press,
  }) : super(key: key);

  final String clubName, address, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: SizeConfig.screenWidth * .93,
        height: getProportionateScreenWidth(170),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
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
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.93,
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
                            clubName,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              address,
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
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
    );
  }
}
