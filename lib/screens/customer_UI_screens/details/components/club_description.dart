import 'package:bookario/components/constants.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/description_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class EventDescription extends StatefulWidget {
  const EventDescription({
    Key key,
    @required this.event,
    this.clubData,
  }) : super(key: key);

  final event, clubData;

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  @override
  void dispose() {
    promoterCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.event['name'],
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(5),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Location point.svg",
                height: getProportionateScreenWidth(15),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: SelectableText(
                    widget.clubData['address'],
                    maxLines: 2,
                    style: TextStyle(color: Colors.white54),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/clock.svg",
              height: getProportionateScreenWidth(14),
            ),
            Text(
              ' ${widget.event['time']}',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Flexible(
        //       child: Container(
        //         child: Text(
        //           "Directions",
        //           style: TextStyle(
        //             color: kSecondaryColor,
        //             decoration: TextDecoration.underline,
        //           ),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 5,
        //     ),
        //     SvgPicture.asset(
        //       "assets/icons/directions.svg",
        //       height: getProportionateScreenWidth(12),
        //       color: kSecondaryColor,
        //     ),
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "About the event",
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ),
        DescriptionTextWidget(text: widget.event['description']),
        Padding(
          padding: EdgeInsets.only(
            top: 25,
          ),
          child: Text(
            "Available Passes:",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontWeight: FontWeight.bold),
          ),
        ),
        AllPrices(priceDescription: widget.event['priceDescription']),
        SizedBox(height: 20),
        Container(
          width: SizeConfig.screenWidth,
          child: FlatButton(
            color: Colors.grey[800],
            onPressed: () {
              promoterPopUp(context);
            },
            child: Text(
              "Are you a promoter?",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        )
      ],
    );
  }

  Future<bool> promoterPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "Enter your Promoter ID:",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          content: promoterCodeFormField(),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                try {
                  if (promoterCode.text.isNotEmpty) {
                    var response = await Networking.getData(
                        'promoters/get-promoter-coupon', {
                      'clubId': widget.clubData['clubId'].toString(),
                      'eventId': widget.event['eventId'].toString(),
                      'promoterId': promoterCode.text.trim(),
                    });
                    // print(response);
                    if (response['success']) {
                      promoterCode.clear();
                      Navigator.pop(context);
                      showCoupons(context, response['data']);
                    } else {
                      Navigator.pop(context);
                      promoterError(context, response['message']);
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Get Coupons",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
          ],
        );
      },
    );
  }

  Future<bool> showCoupons(BuildContext context, List allCoupons) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "Coupons for this event: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(allCoupons.length, (index) {
                return CouponCard(allCoupons: allCoupons, index: index);
              })
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
          ],
        );
      },
    );
  }

  Future<bool> promoterError(BuildContext context, String errorMessage) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            errorMessage,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
          ],
        );
      },
    );
  }

  final promoterCode = TextEditingController();

  TextFormField promoterCodeFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      controller: promoterCode,
      decoration: InputDecoration(
        labelText: "Promoter ID",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  const CouponCard({
    Key key,
    @required this.allCoupons,
    this.index,
  }) : super(key: key);

  final List allCoupons;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Color(0xFFd6d6d6).withOpacity(0.8),
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allCoupons[index]['couponAmount'].toString() + '% OFF',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                allCoupons[index]['couponName'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Coupon code:\n' + allCoupons[index]['couponCode'],
                style: TextStyle(fontSize: 16, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () async {
                await FlutterClipboard.copy(
                    allCoupons[index]['couponAmount'].toString() +
                        '% OFF\n' +
                        allCoupons[index]['couponName'] +
                        '\nCoupon code: ' +
                        allCoupons[index]['couponCode']);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.copy,
                  size: 22,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
