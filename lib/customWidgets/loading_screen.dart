import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:delivery_app/screens/driver/driver_screens/';
// import 'package:delivery_app/screens/merchant/merchant_screens/';



//Driver Loading Screens

//Sign Up
class DriverSignUpLoadingScreen extends StatefulWidget {
  @override
  _DriverSignUpLoadingScreenState createState() => _DriverSignUpLoadingScreenState();
}

class _DriverSignUpLoadingScreenState extends State<DriverSignUpLoadingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.orange[100],
              size: 200,
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingScreenMessage("Signing up"),
                SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 15,
                )
              ],
            ),
          ],
        )
    );
  }
}

//Sign In
class DriverSignInLoadingScreen extends StatefulWidget {
  @override
  _DriverSignInLoadingScreenState createState() => _DriverSignInLoadingScreenState();
}

class _DriverSignInLoadingScreenState extends State<DriverSignInLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.orange[100],
              size: 200,
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingScreenMessage("Signing in"),
                SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 15,
                )
              ],
            ),
          ],
        )
    );
  }
}



//Merchant Loading Screens

//Sign Up
class MerchantSignUpLoadingScreen extends StatefulWidget {
  @override
  _MerchantUpLoadingScreenState createState() => _MerchantUpLoadingScreenState();
}

class _MerchantUpLoadingScreenState extends State<MerchantSignUpLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.orange[100],
              size: 200,
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingScreenMessage("Signing up"),
                SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 15,
                )
              ],
            ),
          ],
        )
    );
  }
}


//Sign In
class MerchantSignInLoadingScreen extends StatefulWidget {
  @override
  _MerchantSignInLoadingScreenState createState() => _MerchantSignInLoadingScreenState();
}

class _MerchantSignInLoadingScreenState extends State<MerchantSignInLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.orange[100],
              size: 200,
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingScreenMessage("Signing in"),
                SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 15,
                )
              ],
            ),
          ],
        )
    );
  }
}

































class LoadingScreenMessage extends StatelessWidget {
  final String notificationMessage;
  LoadingScreenMessage(this.notificationMessage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          notificationMessage,
          style: TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.yellowAccent[700],
          ),
        ),
        // Solid text as fill.
        Text(
          notificationMessage,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 40,
            color: Colors.orange[300],
          ),
        ),
      ],
    );
  }
}
