import 'package:bookario/components/constants.dart';
import 'package:bookario/components/hoveringBackButton.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/club_UI_screens/eventDetails/components/pie_chart_view.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/customer_UI_screens/eventDetails/components/event_description.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  final event;

  Body({Key key, @required this.event}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool addingCouopn = false, loading = false;
  String discountName, discountPercent, couponQuantity;

  FocusNode couponNameFocusNode = FocusNode();
  FocusNode couponPercentFocusNode = FocusNode();
  FocusNode couponQuantityFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(widget.event['image']),
                    HoveringBackButton(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
                  padding: EdgeInsets.only(top: 16, left: 20, right: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      EventDescription(
                        event: widget.event,
                        pressOnSeeMore: () {},
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Text(
                            "Pass Prices",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                      ),
                      AllPrices(
                          priceDescription: widget.event['priceDescription']),
                      ChartView(
                        // TODO: these values will be tickets booked values
                        maleStag: widget.event['maleCount'].toDouble(),
                        femaleStag: widget.event['femaleCount'].toDouble(),
                        couples: widget.event['coupleCount'].toDouble(),
                      ),
                      //TODO: show coupons

                      addingCouopn
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add new coupon",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          couponNameFormField(context),
                                          SizedBox(height: 10),
                                          couponAmountFormField(),
                                          SizedBox(height: 10),
                                          couponQuantityFormField(),
                                        ],
                                      ),
                                    ),
                                    loading ? Loading() : Container()
                                  ],
                                )
                              ],
                            )
                          : Container(),
                      !addingCouopn
                          ? Container(
                              color: Colors.white70,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(10),
                                  top: getProportionateScreenWidth(2),
                                ),
                                child: OutlineButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Colors.white54,
                                  onPressed: () {
                                    setState(() {
                                      addingCouopn = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/coupon.svg",
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Add Coupon",
                                        style: TextStyle(
                                          fontSize: SizeConfig.orientation ==
                                                  Orientation.portrait
                                              ? SizeConfig.screenHeight * .023
                                              : SizeConfig.screenHeight * .04,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.white70,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(10),
                                  top: getProportionateScreenWidth(2),
                                ),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Colors.black,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      setState(() {
                                        loading = true;
                                      });
                                      addCoupon();
                                    }
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      fontSize: SizeConfig.orientation ==
                                              Orientation.portrait
                                          ? SizeConfig.screenHeight * .023
                                          : SizeConfig.screenHeight * .04,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      // TODO: Total Bookings
                      // Container(
                      //   margin: const EdgeInsets.only(top: 10),
                      //   width: double.infinity,
                      //   color: Colors.white,
                      //   child: Column(
                      //     children: [
                      //       divider(),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           RowDisplay(
                      //             // TODO: this number will be total tickets booked value
                      //             icon: "assets/icons/group.svg",
                      //             title: "Total Bookings :  ",
                      //             value: (event['maleCount'] +
                      //                     event['femaleCount'] +
                      //                     event['coupleCount'])
                      //                 .toString(),
                      //           ),
                      //           // RowDisplay(
                      //           //   icon: "assets/icons/m-f.svg",
                      //           //   title: "Male / Female : ",
                      //           //   value: event['maleCount'].toString() +
                      //           //       " / " +
                      //           //       event['femaleCount'].toString(),
                      //           // ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 30,
                      //       ),
                      //       // RichText(
                      //       //   text: TextSpan(
                      //       //     text:
                      //       //         "Earnings\n", // TODO: replace by simply a table variable from database
                      //       //     style: Theme.of(context)
                      //       //         .textTheme
                      //       //         .headline5
                      //       //         .copyWith(fontWeight: FontWeight.bold),
                      //       //     children: [
                      //       //       TextSpan(
                      //       //         text: "₹ " +
                      //       //             (event['maleCount'] * 1000 +
                      //       //                     event['femaleCount'] *
                      //       //                         1500) // variable male & female count
                      //       //                 .toString(),
                      //       //         style: TextStyle(color: kSecondaryColor),
                      //       //       )
                      //       //     ],
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 30),
                      // SizedBox(
                      //   height: SizeConfig.orientation == Orientation.portrait
                      //       ? SizeConfig.screenHeight * .1
                      //       : SizeConfig.screenHeight * .2,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     color: Colors.white70,
          //     child: Padding(
          //       padding: EdgeInsets.only(
          //         left: SizeConfig.screenWidth * 0.15,
          //         right: SizeConfig.screenWidth * 0.15,
          //         bottom: getProportionateScreenWidth(10),
          //         top: getProportionateScreenWidth(2),
          //       ),
          //       child: DefaultButton(
          //         text: "Get Pass",
          //         press: () {},
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void addCoupon() async {
    print(widget.event['eventId']);
    try {
      var response = await Networking.post('events/add-event', {
        //TODO: change endpoint
        'eventId': widget.event['eventId'],
        'couponName': discountName.trim(),
        'couponAmount': discountPercent.trim(),
        'couponQuantity': couponQuantity.trim(),
      });
      if (response['success']) {
        setState(() {
          addingCouopn = false;
          loading = false;
        });
      } else {
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            'Error while adding coupon, try again.',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: kSecondaryColor,
            ),
          ],
        );
      }
    } catch (e) {
      print(e);
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        title: Text(
          'Error while adding coupon, try again.',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 17,
              ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: kSecondaryColor),
            ),
            splashColor: kSecondaryColor,
          ),
        ],
      );
    }
  }

  TextFormField couponNameFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: couponNameFocusNode,
      onSaved: (newValue) => discountName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter coupon name";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Coupon name",
        hintText: "eg: Valentine's special 20% off",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        couponNameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(couponPercentFocusNode);
      },
    );
  }

  TextFormField couponAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: couponPercentFocusNode,
      onSaved: (newValue) => discountPercent = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter coupon discount percent";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Coupon discount percent",
        hintText: "eg: 20",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text('%')),
      ),
      onFieldSubmitted: (value) {
        couponPercentFocusNode.unfocus();
        FocusScope.of(context).requestFocus(couponQuantityFocusNode);
      },
    );
  }

  TextFormField couponQuantityFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.done,
      focusNode: couponQuantityFocusNode,
      onSaved: (newValue) => couponQuantity = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter no. of available coupons.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Number of coupons",
        hintText: "eg: 50",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        couponQuantityFocusNode.unfocus();
      },
    );
  }
}
