import 'dart:convert';
import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/url_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantOrdersHistory extends StatefulWidget {
  final String token;
  MerchantOrdersHistory({Key key, @required this.token}) : super(key: key);
  @override
  _MerchantOrdersHistory createState() => _MerchantOrdersHistory();
}

class _MerchantOrdersHistory extends State<MerchantOrdersHistory> {
  Future<List<List<String>>> getOrderHistory() async {
    List<List<String>> orders = [];
    var uri = Uri(
        scheme: 'https',
        host: httpLink,
        path: '/orders/merchant/get/completed');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http.get(uri, headers: {
      "content-type": "application/json",
      "Authorization": "Token " + T
    });
    var jsonData = json.decode(data.body);
    print(jsonData.toString() + "\n");
    for (var order in jsonData) {
      orders.add([
        order["id"].toString(),
        order["receiver_full_name"],
        order["street"],
        order["driver_phone_number"].toString(),
        order["city"]
      ]);
    }
    ;

    return orders.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MerchantDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              })
        ],
        title: Text(
          "Most Recent Orders",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
      ),
      body: FutureBuilder(
        future: getOrderHistory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: SpinKitCircle(
                color: Colors.orangeAccent,
              )),
            );
          } else {
            return SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 50, left: 5, right: 5),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card( shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          color: Colors.orange,
                          shadowColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (Text('- '+
                              snapshot.data[index][1] +
                                  '\n\n- ' +
                                  snapshot.data[index][2] +
                                  '\n\n- ' +
                                  snapshot.data[index][3] +
                                  '\n\n- ' +
                                  snapshot.data[index][4],
                              style: TextStyle(color: Colors.white,fontSize: 17,fontStyle: FontStyle.italic),
                            )),
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
