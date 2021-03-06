import 'package:delivery_app/customWidgets/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/models/driver_order_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverReceivingOrder extends StatefulWidget {
  final String token;
  DriverReceivingOrder({Key key, @required this.token}) : super(key: key);
  @override
  _DriverReceivingOrderState createState() => _DriverReceivingOrderState();
}

class _DriverReceivingOrderState extends State<DriverReceivingOrder> {
  Future<List<DriverOrderDetailsModel>> _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http
        .get(Uri.parse('https://$httpLink/orders/driver/get/new'), headers: {
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
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DriverDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text('New orders'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  return Scaffold();
                });
              })
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder(
          future: _getOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(child: SpinKitCircle(color: Colors.orangeAccent,)),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.orange,
                    shadowColor: Colors.blue,
                    child: Container(
                      child: Column(
                        children: [
                          Text(snapshot.data[index].receiverFullName,
                              style: TextStyle(color: Colors.red)),
                          Text(
                              '${snapshot.data[index].id},${snapshot.data[index].city},${snapshot.data[index].street},${snapshot.data[index].floor},${snapshot.data[index].receiverPhoneNumber} '),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String T = prefs.getString('token');
                                    print(
                                        "The token in driver first page is ${widget.token}");
                                    await http.put(
                                        Uri.parse(
                                            'http://$httpLink/orders/driver/is_done/${snapshot.data[index].id}'),
                                        headers: {
                                          "content-type": "application/json",
                                          "Authorization": "Token " + T
                                        });

                                    setState(() {
                                      return Scaffold();
                                    });
                                  },
                                  child: Text("Mark as Completed")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
