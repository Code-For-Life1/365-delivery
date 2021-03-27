import 'package:flutter/material.dart';
import 'package:delivery_app/models/driver_authentication_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';

class DriverSignUp extends StatefulWidget {
  @override
  _DriverSignUpState createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
  Future<DriverAuthentication> createToken(String token) async {
    //http://7bc54ac38e57.ngrok.io/register/auth_driver
    var uri = Uri(
      scheme: 'https',
      host: ngrokLink,
      path: '/driver/auth_driver',
    );
    assert(//http://f60fc987a44e.ngrok.io/
        uri.toString() == 'https://$ngrokLink/driver/auth_driver');
    Map<String, String> a = {"token": token};
    var b = json.encode(a);
    print(b);
    http.Response response = await http
        .post(uri, body: b, headers: {"content-type": "application/json"});
    final String responseString = response.body;
    return driverAuthenticationFromJson(responseString);
  }

  DriverAuthentication _token;
  final TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Driver Sign up'),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your token',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: tokenController,
              style: TextStyle(fontSize: 16),
              decoration: new InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                hintText: 'e.g: yj18N3JiVJtu0lPob7BFs4MlHXBGREhh',
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
              final String uniqueToken = tokenController.text;
              final DriverAuthentication driverToken =
                  await createToken(uniqueToken);
              setState(() {
                _token = driverToken;
              });
            },
            child: Text('Validate'),
          ),
          SizedBox(height: 5),
          _token == null
              ? Text("You haven't entered a valid token yet")
              : Text("Token was successfully accepted"),
          SizedBox(height: 200),
          FlatButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed('/driverSignInScreen')},
              child: Text(
                "Already have an account? Sign in",
                style: TextStyle(fontSize: 20, color: Color(0xFF8D8D8D)),
              )),
        ]));
  }
}
