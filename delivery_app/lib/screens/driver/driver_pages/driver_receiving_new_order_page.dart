import 'package:delivery_app/customWidgets/driver_drawer.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/models/order_details_model.dart';

class DriverReceivingOrder extends StatefulWidget {
  final String token;
  DriverReceivingOrder({Key key, @required this.token}) : super(key: key);
  @override
  _DriverReceivingOrderState createState() => _DriverReceivingOrderState();
}

class _DriverReceivingOrderState extends State<DriverReceivingOrder> {
  Future<List<OrderDetailsModel>> _getOrders() async {
    print(widget.token);
    var data = await http.get(Uri.parse('https://$ngrokLink/orders/driver/get'),
        headers: {
          "content-type": "application/json",
          "Authorization": "Token " + widget.token
        });
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
                                  onPressed: () async {
                                    await http.put(
                                        Uri.parse(
                                            'http://$ngrokLink/orders/driver/is_done/${snapshot.data[index].id}'),
                                        headers: {
                                          "content-type": "application/json",
                                          "Authorization": "Token " + widget.token
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
