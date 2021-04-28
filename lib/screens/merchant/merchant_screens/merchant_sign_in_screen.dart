import 'dart:convert';

import 'package:delivery_app/notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../url_link.dart';

class MerchantSignIn extends StatefulWidget {
  @override
  _MerchantSignInState createState() => _MerchantSignInState();
}

class _MerchantSignInState extends State<MerchantSignIn> {
  final TextEditingController merchantUserNameController =
      TextEditingController();
  final TextEditingController merchantPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
        },
        child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Merchant Sign in'),
          centerTitle: true,

        ),
        body: SingleChildScrollView(child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(children: [
              Container(
                transform:
                    Matrix4.translationValues(-screenSize * 0.3, 0.0, 0.0),
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: merchantUserNameController,
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
                margin: EdgeInsets.only(top: 30),
                transform:
                    Matrix4.translationValues(-screenSize * 0.3, 0.0, 0.0),
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
                  controller: merchantPasswordController,
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
                  FocusScope.of(context).unfocus();
                  var uri = Uri(
                    scheme: 'https',
                    host: httpLink,
                    path: '/users/login/merchant',
                  );
                  Map<String, dynamic> info = {
                    "username": merchantUserNameController.text,
                    "password": merchantPasswordController.text,
                  };
                  try {
                    final response = await http.post(uri, body: json.encode(info), headers: {"content-type": "application/json"});
                    if (response.statusCode == 200) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var jsonData = json.decode(response.body);
                      prefs.setString('token', jsonData["token"]);
                      prefs.setString('role', 'merchant');
                      prefs.reload();
                      notificationHandler();
                      Navigator.pushNamed(context, '/merchantHomeScreen', arguments: jsonData["token"]);
                    } else {
                      print(response.statusCode);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.3),
                                child: AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Unable to login with provided credentials"),
                                ));
                          });
                    }
                  } catch (exception) {
                    // error
                  }
                },
                child: Text('Sign in'),
              ),
              SizedBox(height: 20),
            ])))));
  }
}
