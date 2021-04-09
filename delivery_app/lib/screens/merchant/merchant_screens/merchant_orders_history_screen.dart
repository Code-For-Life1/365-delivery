import 'dart:convert';
import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/url_link.dart';

class MerchantOrdersHistory extends StatefulWidget {
  final String token;
  MerchantOrdersHistory({Key key, @required this.token}) : super(key: key);
  @override
  _MerchantOrdersHistory createState() => _MerchantOrdersHistory();
}

class _MerchantOrdersHistory extends State<MerchantOrdersHistory> {
  Future<List<List<String>>> getOrderHistory() async{
    List<List<String>> orders = [];
    var uri = Uri(
      scheme: 'https',
      host: ngrokLink,
      path: '/orders/merchant/get'
    );
    var data = await http.get(uri, headers: {"content-type": "application/json", "Authorization": "Token " + widget.token});
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
      drawer: MerchantDrawer(),
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
        future: getOrderHistory(),
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