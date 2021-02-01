import 'package:bookario/screens/customer_UI_screens/profile/components/body.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);

    //this method not called when user press android back button or quit
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/onlylogo.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text("Profile"),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.edit,
                    size: 22,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Body(),
    );
  }
}
