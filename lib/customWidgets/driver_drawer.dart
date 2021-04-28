import 'package:delivery_app/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivery_app/notifications.dart';

class DriverDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image(
                height: screenSize * 0.23,
                image: (AssetImage('assets/portrait.png')),
              ),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(0xffee8300),
                  Color(0xffee6700)
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
          ),
          // ListTile(title: Text('Driver Menu')),
          // ListTile(title: Text('B')),
          SizedBox(height: 300),
          TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.remove('role');
                deleteNotificationToken(); //do not touch this
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext B) => MyApp()));
              },
              child: Text('Sign out', style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
