import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/order.dart';

class Orders_Placed extends StatefulWidget {
  @override
  _Orders_Placed createState() => _Orders_Placed();
}

class _Orders_Placed extends State<Orders_Placed> {
  Future<List<List<String>>> get_order_history() async{
    List<List<String>> orders = [];
    var uri = Uri(
      scheme: 'https',
      host: 'b5a8706515bb.ngrok.io',
      path: '/orders/merchant/get/41/'
    );
    var data = await http.get(uri);
    var jsonData = json.decode(data.body);
    for (var order in jsonData){
      orders.add([order["receiver_full_name"], order["street"], order["driver"]]);
    };
    return orders;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: get_order_history(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(
              child: Center(child: Text("Loading...")),
            );
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.orange,
                  shadowColor: Colors.blue,
                  child: ListTile(
                    leading: Text(snapshot.data[index][0]),
                    title: Text(snapshot.data[index][1]),
                    subtitle: Text(snapshot.data[index][2]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}