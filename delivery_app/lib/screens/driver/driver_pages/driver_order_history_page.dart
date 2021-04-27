import 'package:delivery_app/customWidgets/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/models/driver_order_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverOrderHistory extends StatefulWidget {
  final String token;
  DriverOrderHistory({Key key, @required this.token}) : super(key: key);
  @override
  _DriverOrderHistoryState createState() => _DriverOrderHistoryState();
}

class _DriverOrderHistoryState extends State<DriverOrderHistory> {
  Future<List<DriverOrderDetailsModel>> _getOrders() async {
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/orders/driver/get/completed',
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http.get(uri, headers: {
      "content-type": "application/json",
      "Authorization": "Token " + T
    });
    var jsonData = json.decode(data.body);
    List<DriverOrderDetailsModel> orders = [];
    for (var u in jsonData) {
      DriverOrderDetailsModel driver = DriverOrderDetailsModel(
          u["id"],
          u["city"],
          u["street"],
          u["building"],
          u["floor"],
          u["receiver_full_name"],
          u["receiver_phone_number"]);
      orders.add(driver);
    }
    print(orders.length);
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DriverDrawer(),
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder(
          future: _getOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: SpinKitCircle(
                  color: Colors.orangeAccent,
                )),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      shadowColor: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '- ' +
                              snapshot.data[index].receiverFullName +
                              '\n\n- ' +
                              snapshot.data[index].city +
                              '\n\n- ' +
                              snapshot.data[index].street +
                              '\n\n- ' +
                              snapshot.data[index].floor +
                              '\n\n- ' +
                              snapshot.data[index].receiverPhoneNumber,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                        ),
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
