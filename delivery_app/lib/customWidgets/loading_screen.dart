import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class SignUpLoadingScreen extends StatefulWidget {
  @override
  _SignUpLoadingScreenState createState() => _SignUpLoadingScreenState();
}

class _SignUpLoadingScreenState extends State<SignUpLoadingScreen> {
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


class SignInLoadingScreen extends StatefulWidget {
  @override
  _SignInLoadingScreenState createState() => _SignInLoadingScreenState();
}

class _SignInLoadingScreenState extends State<SignInLoadingScreen> {
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
