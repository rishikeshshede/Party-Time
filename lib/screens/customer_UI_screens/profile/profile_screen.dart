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
        leading: Padding(
          padding: const EdgeInsets.all(8),
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
                    color: Theme.of(context).primaryColor,
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
