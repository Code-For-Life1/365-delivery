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
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/users/driver/check_token',
    );
    Map<String, String> a = {"token": token};
    var b = json.encode(a);
    print(b);

    try {
      http.Response response = await http
          .post(uri, body: b, headers: {"content-type": "application/json"});
      var data = json.decode(response.body);
      if (response.statusCode == 400) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: AlertDialog(
                    title: Text("Error"),
                    content: Text(data["response"]),
                  ));
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: AlertDialog(
                    title: Text("Success"),
                    content: Text(data["response"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/DriverRegistrationCredentials',
                                arguments: data["token"]);
                          },
                          child: Text("Continue"))
                    ],
                  ));
            });
      }
    } catch (exception) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                child: AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              '/DriverRegisterationCredentials',
                              arguments: "a32r");
                        },
                        child: Text("continue"))
                  ],
                  title: Text("Error"),
                  content: Text("Unable to validate right now."),
                ));
          });
    }

    // return driverAuthenticationFromJson(responseString);
  }

  DriverAuthentication _token;
  final TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                hintText: 'e.g: BGREhh',
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
