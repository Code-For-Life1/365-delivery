import 'package:delivery_app/customWidgets/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/models/order_details_model.dart';

//CLASS NOT WORKING YET

class DriverOrderHistory extends StatefulWidget {
  final String token;
  DriverOrderHistory({Key key, @required this.token}) : super(key: key);
  @override
  _DriverOrderHistoryState createState() => _DriverOrderHistoryState();
}

class _DriverOrderHistoryState extends State<DriverOrderHistory> {
  Future<List<OrderDetailsModel>> _getOrders() async {
    var client = http.Client();
    var uri = Uri(
      scheme: 'https',
      host: ngrokLink,
      path: '/orders/driver/get/completed',
    );
    print("The token in driver second page is ${widget.token}");
    var data = await http.get(uri, headers: {"content-type": "application/json", "Authorization": "Token " + widget.token});
    var jsonData = json.decode(data.body);
    List<OrderDetailsModel> orders = [];
    for (var u in jsonData) {
      OrderDetailsModel driver = OrderDetailsModel(
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
                child: Center(child: Text("Loading...")),
              );
            } else {
              return ListView.builder(
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
                                  onPressed: () {},
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
