import 'dart:convert';

import 'package:delivery_app/customWidgets/new_order_button.dart';
import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../url_link.dart';

class MerchantOrder extends StatefulWidget {
  final String token;

  MerchantOrder({Key key, @required this.token}) : super(key: key);

  @override
  _MerchantOrderState createState() => _MerchantOrderState();
}

class _MerchantOrderState extends State<MerchantOrder> {
  Future<List<List<String>>> getOrderHistory() async{
    List<List<String>> orders = [];
    var uri = Uri(
        scheme: 'https',
        host: ngrokLink,
        path: '/orders/merchant/get/new'
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http.get(uri, headers: {"content-type": "application/json", "Authorization": "Token " + T});
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
        actions: [],
        backgroundColor: Colors.orange[800],
        title: Text(
          'Delivery Status',
        ),
        centerTitle: true,
      ),
      drawer: MerchantDrawer(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getOrderHistory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 250, 0, 250),
                  child: Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 40.0, color: Colors.orange[500]),
                  )),
              SizedBox(),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: FancyButton(token: widget.token))
            ]);
          } else {
            return Column(
              children: [
                SingleChildScrollView(padding: EdgeInsets.only(top: 50, left: 5, right: 5),child:Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
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
                )),
                Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: FancyButton(token: widget.token)
                )
              ]
            );
          }
        },
      ),
    );
  }
}
