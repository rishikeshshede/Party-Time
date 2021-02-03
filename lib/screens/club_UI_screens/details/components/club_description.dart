import 'package:bookario/components/constants.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/description_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/size_config.dart';

class ClubDescription extends StatefulWidget {
  const ClubDescription({
    Key key,
    @required this.club,
    this.pressOnSeeMore,
  }) : super(key: key);

  final club;
  final GestureTapCallback pressOnSeeMore;

  @override
  _ClubDescriptionState createState() => _ClubDescriptionState();
}

class _ClubDescriptionState extends State<ClubDescription> {
  bool addingPromoter = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getProportionateScreenWidth(10),
            ),
            child: Text(
              "About us",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          DescriptionTextWidget(text: widget.club['description']),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
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
                          widget.club['address'],
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  addPromoterPopUp(context);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[300]),
                        child: SvgPicture.asset(
                          "assets/icons/add-user.svg",
                          height: 20,
                        ),
                      ),
                      Text(
                        "Add\nPromoter",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.white54),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<bool> addPromoterPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return addingPromoter
            ? Loading()
            : AlertDialog(
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                title: Text(
                  "Enter promoter's email ID:",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 17, color: Colors.white),
                ),
                content: promoterEmailFormField(),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      if (promoterEmail.text.isNotEmpty) {
                        setState(() {
                          addingPromoter = true;
                        });
                        var response =
                            await Networking.post('promoters/add-promoter', {
                          'clubId': widget.club['clubId'],
                          'promoterEmail': promoterEmail.text.trim(),
                        });
                        if (response['success']) {
                          setState(() {
                            addingPromoter = false;
                          });
                          Navigator.pop(context);
                          promoterEmail.clear();
                          promoterCreated(context, response['data']);
                        } else {
                          setState(() {
                            addingPromoter = false;
                          });
                          Navigator.pop(context);
                          promoterError(context, response['message']);
                        }
                      }
                    },
                    child: Text(
                      "Add",
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
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: Text(
            errorMessage,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white54),
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

  Future<bool> promoterCreated(BuildContext context, String promoterId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: Text(
            "Promoter Created successfully.",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Promoter's ID:",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 14,
                      color: Colors.white54,
                    ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                color: Colors.black12,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      promoterId,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                await FlutterClipboard.copy(promoterId);
                Navigator.pop(context);
              },
              child: Text(
                "Copy",
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

  final promoterEmail = TextEditingController();

  TextFormField promoterEmailFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      controller: promoterEmail,
      decoration: InputDecoration(
        labelText: "Promoter Email ID",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
