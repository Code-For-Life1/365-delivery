import 'package:flutter/material.dart';
import 'package:delivery_app/models/driver_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantRegisterDriver extends StatefulWidget {
  final String token;
  MerchantRegisterDriver({Key key, @required this.token}) : super(key: key);
  @override
  _MerchantRegisterDriverState createState() => _MerchantRegisterDriverState();
}

class _MerchantRegisterDriverState extends State<MerchantRegisterDriver> {
  Future<DriverModel> addDriver(
      String firstName, String lastName, String phoneNumber) async {
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/users/driver/register',
    );
    Map<String, String> a = {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber
    };
    var b = json.encode(a);
    print(b);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String T = prefs.getString('token');
      print("t = " + T);

      http.Response response = await http.post(uri, body: b, headers: {
        "content-type": "application/json",
        "Authorization": "Token " + T
      });
      // all the code below will be skipped if http.post throws an Exception
      print("hello" + response.body + (response.statusCode).toString());
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
                      content: Text("At least one field is missing.")));
            });
      } else if (response.statusCode == 201) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: AlertDialog(
                    title: Text("Success!"),
                    content: Text("Driver " +
                        data["first_name"] +
                        " " +
                        data["last_name"] +
                        " successfully added."),
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
                  title: Text("Error"),
                  content: Text("Unable to add driver at the moment."),
                ));
          });
    }
  }

  DriverModel _driver;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 56 * 2.0,
        leading: Center(
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: FlatButton(
              onPressed: () async {
                final String firstName = firstNameController.text;
                final String lastName = lastNameController.text;
                final String phoneNumber = phoneNumberController.text;
                final DriverModel newDriver =
                    await addDriver(firstName, lastName, phoneNumber);
                setState(() {
                  _driver = newDriver;
                });
              },
              child: Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Add Driver",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF6200),
        toolbarHeight: 53,
      ),
      body: Container(
          transform: Matrix4.translationValues(0.0, (screenSize * 0.15), 0.0),
          child: Center(
              child: Column(children: [
            Image(
              height: screenSize * 0.2,
              image: AssetImage("assets/portrait.png"),
            ),
            Container(
                margin: EdgeInsets.only(top: screenSize * 0.06),
                child: new Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: screenSize * 0.05,
                  runSpacing: 15,
                  children: [
                    Container(
                      width: screenSize * 0.4,
                      child: TextField(
                        controller: firstNameController,
                        style: TextStyle(fontSize: 22),
                        decoration: new InputDecoration(
                          fillColor: Color(0xFFF8F8F8),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 7.0),
                          hintText: 'First name',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize * 0.4,
                      child: TextField(
                        controller: lastNameController,
                        style: TextStyle(fontSize: 22),
                        decoration: new InputDecoration(
                          fillColor: Color(0xFFF8F8F8),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 7.0),
                          hintText: 'Last name',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: screenSize * 0.85,
                        child: TextField(
                          controller: phoneNumberController,
                          style: TextStyle(fontSize: 22),
                          decoration: new InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Phone number',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
            Container(
              margin: EdgeInsets.only(
                top: screenSize * 0.5,
              ),
            )
          ]))),
      backgroundColor: Color(0xFFF6F8F5),
    );
  }
}
