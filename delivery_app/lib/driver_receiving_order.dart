import 'package:flutter/material.dart';
import 'package:delivery_app/url_link.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/order_details_model.dart';
import 'package:web_socket_channel/io.dart';

class DriverReceivingOrder extends StatefulWidget {
  final String driverID;
  DriverReceivingOrder({Key key, @required this.driverID}) : super(key: key);
  @override
  _DriverReceivingOrderState createState() => _DriverReceivingOrderState();
}

class _DriverReceivingOrderState extends State<DriverReceivingOrder> {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  Future<List<OrderDetailsModel>> _getNewOrders() async {
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
        child: StreamBuilder(
          stream: channel.stream,
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

