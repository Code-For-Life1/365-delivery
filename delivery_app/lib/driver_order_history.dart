import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/order_details_model.dart';

class DriverOrderHistory extends StatefulWidget {
  final String driverID;
  DriverOrderHistory({Key key, @required this.driverID}) : super(key: key);
  @override
  _DriverOrderHistoryState createState() => _DriverOrderHistoryState();
}

class _DriverOrderHistoryState extends State<DriverOrderHistory> {
  Future<List<OrderDetailsModel>> _getOrders() async {
    //http://a84a794b3db6.ngrok.io/
    //{{ngrok}}/orders/merchant/get/42
    var client = http.Client();
    try {
      var data =
      await client.get(Uri.parse('https://1dd6f3ebf015.ngrok.io/orders/driver/get/${widget.driverID}'));
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
    } finally {
      //client.close();
    }
    // var uri = Uri(
    //   scheme: 'https',
    //   host: theLink,
    //   path: '/mydrivers/39',
    // );
    // assert(//http://f60fc987a44e.ngrok.io/
    // uri.toString() == 'https://$theLink/mydrivers/39');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Hello')),
            ListTile(title: Text('A')),
            ListTile(title: Text('B')),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Driver Home Page'),
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
                          Text(snapshot.data[index].receiverFullName,style:TextStyle(color: Colors.red)),
                          Text(
                              '${snapshot.data[index].id},${snapshot.data[index].city},${snapshot.data[index].street},${snapshot.data[index].floor},${snapshot.data[index].receiverPhoneNumber} '
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: (){
                                  }, child: Text("Mark as Completed")
                              ),
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
