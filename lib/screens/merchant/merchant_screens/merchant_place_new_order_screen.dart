import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/models/driver_order_details_model.dart';
import 'package:delivery_app/url_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantPlaceNewOrder extends StatefulWidget {
  final String token;
  MerchantPlaceNewOrder({Key key, @required this.token}) : super(key: key);
  @override
  State<MerchantPlaceNewOrder> createState() => _MerchantPlaceNewOrder();
}

class _MerchantPlaceNewOrder extends State<MerchantPlaceNewOrder> {
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final TextEditingController c5 = TextEditingController();
  final TextEditingController c6 = TextEditingController();

  List<String> drivers = [];
  Map<String, String> ID = new Map();
  Future<List<String>> getDrivers() async {
    drivers.clear();
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/users/merchant/drivers',
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http
        .get(uri, headers: {"Authorization": "Token " + T});
    assert(data.statusCode == 200);
    var jsonData = json.decode(data.body);
    for (var driver in jsonData) {
      print(driver.toString() + '\n');
      if (!drivers.contains(driver["first_name"] + " " + driver["last_name"]))
        drivers.add(driver["first_name"] + " " + driver["last_name"]);
      ID.putIfAbsent(driver["first_name"] + " " + driver["last_name"], () => driver["phone_number"]);
    }
    return drivers;
  }

  Future<DriverOrderDetailsModel> createOrder(
      String r_name,
      String r_phone,
      String st,
      String bldg,
      String city,
      String flr,
      String driver) async {

    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/orders/merchant/set_order',
    );
    Map<String, dynamic> info = {
      "receiver_full_name": r_name,
      "receiver_phone_number": r_phone,
      "street": st,
      "building": bldg,
      "city": city,
      "floor": flr,
      "driver": ID[driver],
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    final response = await http.post(uri, body: json.encode(info), headers: {
      "content-type": "application/json",
      "Authorization": "Token " + T
    });
    if (response.statusCode >= 200) {
      // json.decode(response.body), get id, POJO
    } else {
      throw Exception('Failed to create order');
    }
  }

  String currentDriver = "Select a driver";
  @override
  Widget build(BuildContext context) {
    Future<List<String>> listOfDrivers = getDrivers();
    double screenSize = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: listOfDrivers,
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "New Order",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            centerTitle: true,
            backgroundColor: Colors.orange[800],
            toolbarHeight: 53,
          ),
          body: Container(
              transform:
                  Matrix4.translationValues(0.0, (screenSize * 0.15), 0.0),
              child: Center(
                  child: Column(children: [
                Container(
                    margin: EdgeInsets.only(left: 40.0),
                    child: Text(
                        "Fill in below the information about the order:",
                        style: TextStyle(fontSize: 20))),
                Container(
                    margin: EdgeInsets.only(top: screenSize * 0.06),
                    child: new Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: screenSize * 0.05,
                      runSpacing: 15,
                      children: [
                        Container(
                          width: screenSize * 0.85,
                          child: TextField(
                            controller: c1,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 15.0),
                              hintText: 'Receiver\'s full name',
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
                            controller: c2,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 15.0),
                              hintText: 'Receiver\'s phone number',
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
                            controller: c3,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 15.0),
                              hintText: 'Street',
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
                            controller: c4,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 15.0),
                              hintText: 'Building',
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
                            controller: c5,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 7.0),
                              hintText: 'City',
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
                            controller: c6,
                            style: TextStyle(fontSize: 22),
                            decoration: new InputDecoration(
                              fillColor: Color(0xFFF8F8F8),
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 7.0),
                              hintText: 'Floor',
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: screenSize * 0.1),
                  child: DropdownButton(
                    hint: Text(currentDriver, style: TextStyle(fontSize: 20)),
                    items: drivers.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (d) => {
                      this.setState(() {
                        currentDriver = d;
                      }),
                      FocusScope.of(context).unfocus()
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenSize * 0.1,
                  ),
                  child: TextButton(
                      onPressed: () => {
                            createOrder(c1.text, c2.text, c3.text, c4.text,
                                c5.text, c6.text, currentDriver)
                          },
                      child: Text(
                        "Send order",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF8D8D8D)),
                      )),
                )
              ]))),
          backgroundColor: Color(0xFFF6F8F5),
        );
      },
    );
  }
}
