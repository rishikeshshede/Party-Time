import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool detailsLoading;
  String name, phone, email, age, gender;

  @override
  void initState() {
    super.initState();
    name = '';
    phone = '';
    email = '';
    age = '';
    gender = '';
    detailsLoading = true; // true
    populateDetails();
  }

  populateDetails() async {
    String uid = await PersistenceHandler.getter('uid');
    // print(uid);
    var response =
        await Networking.getData('user/get-user-details', {"userId": uid});
    // print(response);
    if (response['success'] && response['data'].length != 0) {
      setState(() {
        name = response['data'][0]['name'];
        age = response['data'][0]['age'].toString();
        phone = response['data'][0]['phone'];
        email = response['data'][0]['email'];
        gender = response['data'][0]['gender'];
        detailsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: SizeConfig.screenHeight * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Name",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Phone no.",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Email ID",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Age",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Gender",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          detailsLoading
              ? Expanded(child: Loading())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ":  $name",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      ":  $phone",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      ":  $email",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      ":  $age yrs",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      ":  $gender",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
