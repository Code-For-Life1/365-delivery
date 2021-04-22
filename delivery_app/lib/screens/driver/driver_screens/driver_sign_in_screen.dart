import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../url_link.dart';

class DriverSignIn extends StatefulWidget {
  @override
  _DriverSignInState createState() => _DriverSignInState();
}

class _DriverSignInState extends State<DriverSignIn> {
  final TextEditingController driverUserNameController = TextEditingController();
  final TextEditingController driverPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Driver Sign in'),
          centerTitle: true,
        ),
        body: Container(
            margin: EdgeInsets.only(top: 100),
            child:Column(children: [
          Container(
            transform: Matrix4.translationValues(-screenSize * 0.3, 0.0, 0.0),
            child: Text(
              'Username',
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: driverUserNameController,
              style: TextStyle(fontSize: 16),
              decoration: new InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:30),
            transform: Matrix4.translationValues(-screenSize * 0.3, 0.0, 0.0),
            child: Text(
              'Password',
              style: TextStyle(fontSize: 25),
            ),
          ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: driverPasswordController,
                  style: TextStyle(fontSize: 16),
                  decoration: new InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
            onPressed: () async {
              final String driver_username = driverUserNameController.text;
              final String driver_pass = driverPasswordController.text;
              var uri = Uri(
                scheme: 'https',
                host: ngrokLink,
                path: '/users/login/driver',
              );
              Map<String, dynamic> info = {
                "username": driver_username,
                "password": driver_pass,
              };
              final response = await http.post(uri,
                  body: json.encode(info), headers: {"content-type": "application/json"});
              if (response.statusCode == 200) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var jsonData = json.decode(response.body);
                prefs.setString('token', jsonData["token"]);
                prefs.setString('role', 'driver');
                prefs.reload();
                print("token in prefs is " + prefs.getString("token") + '\n');
                Navigator.pushNamed(context, '/driverHomeScreen', arguments: jsonData["token"]);
              } else {
                throw Exception('Failed to sign in');
              }
            },
            child: Text('Sign in'),
          ),
          SizedBox(height: 20),
        ])));
  }
}
