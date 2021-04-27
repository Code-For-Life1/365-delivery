import 'dart:convert';

import 'package:delivery_app/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../url_link.dart';

class DriverRegistrationCredentials extends StatefulWidget {
  final String token;

  DriverRegistrationCredentials({Key key, @required this.token})
      : super(key: key);

  @override
  _DriverRegistrationCredentialsState createState() =>
      _DriverRegistrationCredentialsState();
}

class _DriverRegistrationCredentialsState
    extends State<DriverRegistrationCredentials> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController PasswordController = TextEditingController();
    final TextEditingController Password2Controller = TextEditingController();
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Username and Password'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 100, left: 30, right: 30),
          child: Column(
            children: [
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: PasswordController,
                decoration: new InputDecoration(
                    fillColor: Color(0xFFF8F8F8), hintText: "Password"),
              ),
              SizedBox(height: 30),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: Password2Controller,
                decoration: new InputDecoration(
                    fillColor: Color(0xFFF8F8F8), hintText: "Confirm Password"),
              ),
              SizedBox(height: 30),
              TextButton(
                  onPressed: () async {
                    if (PasswordController.text != Password2Controller.text) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.2),
                                child: AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Passwords do not match"),
                                ));
                          });
                    } else {
                      var uri = Uri(
                        scheme: 'https',
                        host: httpLink,
                        path: '/users/driver/auth_driver',
                      );
                      Map<String, String> a = {
                        "token": widget.token,
                        "password": PasswordController.text,
                        "password2": Password2Controller.text
                      };
                      var b = json.encode(a);
                      print(b);
                      try {
                        http.Response response = await http.post(uri,
                            body: b,
                            headers: {"content-type": "application/json"});
                        // all the code below will be skipped if http.post throws an Exception
                        var data = json.decode(response.body);
                        if (response.statusCode == 201) {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString('token', data["token"]);
                          prefs.setString('role', 'driver');
                          prefs.reload();
                          await notificationHandler();
                          Navigator.of(context).pushReplacementNamed('/driverHomeScreen', arguments: data["token"]);
                        } else {
                          // error
                        }
                      } catch (exception) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.2),
                                  child: AlertDialog(
                                    title: Text("Error"),
                                    content:Text("Unable to log in at the moment."),
                                  ));
                            });
                      }
                    }
                  },
                  child: Text("Sign in"))
            ],
          ),
        ));
  }
}
