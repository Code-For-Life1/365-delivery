import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/url_link.dart';

class Orders_Placed extends StatefulWidget {
  @override
  _Orders_Placed createState() => _Orders_Placed();
}

class _Orders_Placed extends State<Orders_Placed> {
  Future<List<List<String>>> get_order_history() async{
    List<List<String>> orders = [];
    var uri = Uri(
      scheme: 'https',
      host: theLink,
      path: '/orders/merchant/get/3'
    );
    var data = await http.get(uri);
    var jsonData = json.decode(data.body);
    print(jsonData.toString() + "\n");
    for (var order in jsonData){
      orders.add([order["id"].toString(), order["receiver_full_name"], order["street"], order["driver"].toString(), order["city"]]);
    };

    return orders.reversed.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Most Recent Orders",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
        toolbarHeight: 53,
      ),
      body: FutureBuilder(
        future: get_order_history(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(
              child: Center(child: Text("Loading...")),
            );
          }
          else {
            return SingleChildScrollView(physics: ScrollPhysics(), padding: EdgeInsets.only(top: 50, left: 5, right: 5),child:Column(
              children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.orange,
                        shadowColor: Colors.blue,
                        child: ListTile(
                          leading: Container(child:Text(snapshot.data[index][1] + "\n\nID: " + snapshot.data[index][0].toString()), width: 55,),
                          title: Text(snapshot.data[index][2], style: TextStyle(color: Colors.white, fontSize: 20)),
                          subtitle: Text(snapshot.data[index][4]),
                        ),
                      );
                    },
                  ),



              ],
            ));
          }
        },
      ),
    );
  }
}