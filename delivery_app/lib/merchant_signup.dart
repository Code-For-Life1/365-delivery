import 'package:delivery_app/merchant_page.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/models/merchant_model.dart';
import 'url_link.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Merchant: full name, phone number, company name, company address.
class MerchantSignUp extends StatefulWidget {
  @override
  _MerchantSignUpState createState() => _MerchantSignUpState();
}

class _MerchantSignUpState extends State<MerchantSignUp> {
  Future<MerchantModel> addMerchant(String firstName, String lastName,
      String companyName, String companyAddress, String phoneNumber) async {
    //http://a84a794b3db6.ngrok.io/
    var uri = Uri(
      scheme: 'https',
      host: theLink,
      path: '/register/driver/39',
    );
    assert(
        uri.toString() == 'https://a84a794b3db6.ngrok.io/register/driver/39');

    Map<String, String> a = {
      "first_name": firstName,
      "last_name": lastName,
      "company_name": companyName,
      "company_address": companyAddress,
      "phone_number": phoneNumber
    };
    var b = json.encode(a);
    print(b);
    // http.Response response = await http
    //     .post(uri, body: b, headers: {"content-type": "application/json"});
    // final String responseString = response.body;
    // return merchantModelFromJson(responseString);
  }

  MerchantModel _merchant;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
            child: FlatButton(
              onPressed: () async {
                final String firstName = firstNameController.text;
                final String lastName = lastNameController.text;
                final String companyName = companyNameController.text;
                final String companyAddress = companyAddressController.text;
                final String phoneNumber = phoneNumberController.text;
                final MerchantModel newMerchant = await addMerchant(firstName,
                    lastName, companyName, companyAddress, phoneNumber);
                setState(() {
                  _merchant = newMerchant;
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MerchantPage()));
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
                        ))
                  ],
                )),
            Container(
              margin: EdgeInsets.only(
                top: screenSize * 0.35,
              ),
              child: FlatButton(
                  onPressed: () => {},
                  child: Text(
                    "Already have an account? Sign in",
                    style: TextStyle(fontSize: 20, color: Color(0xFF8D8D8D)),
                  )),
            )
          ]))),
      backgroundColor: Color(0xFFF6F8F5),
    );
  }
}
