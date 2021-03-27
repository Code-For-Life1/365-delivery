import 'package:flutter/material.dart';

class DriverDrawer extends StatelessWidget {
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
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Text('Sign out', style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
