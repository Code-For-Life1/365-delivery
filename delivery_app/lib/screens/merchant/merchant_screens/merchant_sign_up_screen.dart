import 'package:flutter/material.dart';
import 'package:delivery_app/models/merchant_model.dart';
import 'package:delivery_app/url_link.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Merchant: full name, phone number, company name, company address.
class MerchantSignUp extends StatefulWidget {
  @override
  _MerchantSignUpState createState() => _MerchantSignUpState();
}

class _MerchantSignUpState extends State<MerchantSignUp> {
  Future<MerchantModel> addMerchant(
      String firstName,
      String lastName,
      String companyName,
      String companyAddress,
      String phoneNumber,
      String password,
      String confirmation_password) async {
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/users/merchant/register',
    );
    Map<String, String> a = {
      "first_name": firstName,
      "last_name": lastName,
      "company_name": companyName,
      "company_address": companyAddress,
      "phone_number": phoneNumber,
      "password": password,
      "password2": confirmation_password
    };
    var b = json.encode(a);
    print(b);
    try {
      http.Response response = await http
          .post(uri, body: b, headers: {"content-type": "application/json"});
      var data = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(data["token"] + "\n");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data["token"]);
        prefs.setString('role', 'merchant');
        prefs.reload();
        await notificationHandler();
        Navigator.of(context).pushReplacementNamed('/merchantHomeScreen',
            arguments: data["token"]);
      } else {
        if (password != confirmation_password) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: AlertDialog(
                      title: Text("Error"),
                      content: Text("Passwords do not match."),
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
                      title: Text("Error"),
                      content: Text(
                          "Merchant with this phone number already exists.\nPlease log in."),
                    ));
              });
        }
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
                  content: Text("Unable to add merchant at the moment."),
                ));
          });
    }
  }

  MerchantModel _merchant;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
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
            child: TextButton(
              onPressed: () async {
                final String firstName = firstNameController.text;
                final String lastName = lastNameController.text;
                final String companyName = companyNameController.text;
                final String companyAddress = companyAddressController.text;
                final String phoneNumber = phoneNumberController.text;
                final String password = passwordController.text;
                final String password2 = passwordConfirmationController.text;
                addMerchant(firstName, lastName, companyName, companyAddress,
                    phoneNumber, password, password2);
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
          "Sign up",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF6200),
        toolbarHeight: 53,
      ),
      body: Container(
          transform: Matrix4.translationValues(0.0, (screenSize * 0.15), 0.0),
          child: SingleChildScrollView(child:Center(
              child: Column(children: [
            Image(
              height: screenSize * 0.15,
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
                        controller: companyNameController,
                        style: TextStyle(fontSize: 22),
                        decoration: new InputDecoration(
                          fillColor: Color(0xFFF8F8F8),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 15.0),
                          hintText: 'Company name',
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
                          controller: companyAddressController,
                          style: TextStyle(fontSize: 22),
                          decoration: new InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Company address',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                          ),
                        )),
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
                        )),
                    Container(
                        width: screenSize * 0.85,
                        child: TextField(
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          controller: passwordController,
                          style: TextStyle(fontSize: 22),
                          decoration: new InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Password',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        width: screenSize * 0.85,
                        child: TextField(
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          controller: passwordConfirmationController,
                          style: TextStyle(fontSize: 22),
                          decoration: new InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            hintText: 'Confirm password',
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
                top: screenSize * 0.13,
              ),
              child: TextButton(
                  onPressed: () => {
                        Navigator.of(context).pushNamed('/merchantSignInScreen')
                      },
                  child: Text(
                    "Already have an account? Sign in",
                    style: TextStyle(fontSize: 20, color: Color(0xFF8D8D8D)),
                  )),
            )
          ])))),
      backgroundColor: Color(0xFFF6F8F5),
    );
  }
}
