import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/order.dart';

class new_order extends StatefulWidget {
  @override
  State<new_order> createState() {
    return S();
  }
}
class S extends State<new_order>{
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final TextEditingController c5 = TextEditingController();
  final TextEditingController c6 = TextEditingController();

  List<String> drivers = new List();
  Future<List<String>> getDrivers() async{
    drivers.clear();
    var uri = Uri(
      scheme: 'https',
      host: '341ef0d16512.ngrok.io',
      path: '/mydrivers/39',
    );
    var data = await http.get(uri);
    assert(data.statusCode == 200);
    var jsonData = json.decode(data.body);
    for (var driver in jsonData){
      drivers.add(driver["first_name"] + " " + driver["last_name"]);
    };
    return drivers;
  }
  Future<Order> createOrder(String r_name, String r_phone, String st, String bldg, String city, int flr, int driver_id, int merchant_id) async {
    var uri = Uri(
      scheme: 'https',
      host: 'b5a8706515bb.ngrok.io',
      path: '/orders/merchant/set_order',
    );
    Map<String, dynamic> info = {
      "receiver_full_name": r_name,
      "receiver_phone_number": r_phone,
      "street": st,
      "building": bldg,
      "city": city,
      "floor": flr,
      "driver": 41,
      "merchant": 39
    };
    final response = await http.post(uri, body: json.encode(info), headers: {"content-type": "application/json"});
    if (response.statusCode >= 200) {
      // to do: receive order id
    } else {
      throw Exception('Failed to create order');
    }
  }

  String current_driver = "Select a driver";
  @override
  Widget build(BuildContext context) {
    Future<List<String>> list_of_drivers = getDrivers();
    double screenSize = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: list_of_drivers,
      builder: (context, snapshot) {
        return Scaffold(
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
              transform: Matrix4.translationValues(0.0, (screenSize * 0.15), 0.0),
              child: Center(
                  child: Column(children: [
                    Container(
                        margin: EdgeInsets.only(left: 40.0),
                        child: Text("Fill in below the information about the order:", style: TextStyle(fontSize: 20))
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
                        hint: Text(current_driver, style: TextStyle(fontSize: 20)),
                        items: drivers.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (d)=>{
                          this.setState(() {current_driver = d;})
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: screenSize * 0.1,
                      ),
                      child: FlatButton(
                          onPressed: () => {
                              createOrder(c1.text, c2.text, c3.text, c4.text, c5.text, int.parse(c6.text), 41, 39)
                          },
                          child: Text(
                            "Send order",
                            style: TextStyle(fontSize: 20, color: Color(0xFF8D8D8D)),
                          )),
                    )
                  ]))),
          backgroundColor: Color(0xFFF6F8F5),
        );
      },
    );
  }
}