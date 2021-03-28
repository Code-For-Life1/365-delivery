import 'package:flutter/material.dart';

class DriverSignIn extends StatefulWidget {
  @override
  _DriverSignInState createState() => _DriverSignInState();
}

class _DriverSignInState extends State<DriverSignIn> {
  final TextEditingController driverIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Driver Sign in'),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your ID',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: driverIdController,
              style: TextStyle(fontSize: 16),
              decoration: new InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                hintText: 'e.g: 28',
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextButton(
            onPressed: () {
              final String driverID = driverIdController.text;
              print('The entered ID is: $driverID');
              Navigator.of(context)
                  .pushReplacementNamed('/driverHomeScreen', arguments: driverID);
            },
            child: Text('Sign in'),
          ),
          SizedBox(height: 20),
        ]));
  }
}
