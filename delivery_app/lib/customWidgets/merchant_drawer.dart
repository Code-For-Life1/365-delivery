import 'package:delivery_app/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Hello')),
          ListTile(title: Text('A')),
          ListTile(title: Text('B')),
          SizedBox(height: 300),
          TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.remove('role');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext B) => MyApp()));
              },
              child: Text('Sign out', style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
