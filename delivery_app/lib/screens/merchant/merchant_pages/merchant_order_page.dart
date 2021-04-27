import 'dart:collection';
import 'dart:convert';

import 'package:delivery_app/customWidgets/new_order_button.dart';
import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../url_link.dart';
import 'package:delivery_app/models/merchant_order_details_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:delivery_app/notifications.dart';

// int orderCounter = 0;
Map<int, int> a = new Map();
class MerchantOrder extends StatefulWidget {
  final String token;
  MerchantOrder({Key key, @required this.token}) : super(key: key);

  @override
  _MerchantOrderState createState() => _MerchantOrderState();
}

class _MerchantOrderState extends State<MerchantOrder> {
  Future<List<MerchantOrderDetailsModel>> getPendingMerchantOrders() async {
    var uri =
        Uri(scheme: 'https', host: httpLink, path: '/orders/merchant/get/new');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http.get(uri, headers: {
      "content-type": "application/json",
      "Authorization": "Token " + T
    });
    var jsonData = json.decode(data.body);
    List<MerchantOrderDetailsModel> orders = [];
    print(jsonData.toString() + "\n");
    for (var order in jsonData) {
      MerchantOrderDetailsModel newOrder = MerchantOrderDetailsModel(
          order['id'],
          order['receiver_full_name'],
          order['receiver_phone_number'],
          order['merchant'],
          order['driver'],
          order['driver_name'],
          order['status'],
          order['city'],
          order['street'],
          order['building'],
          order['floor']);
      // a.putIfAbsent(orderCounter, () => order["id"]);
      // orderCounter +=1;
      orders.add(newOrder);
    }
    return orders.reversed.toList();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                refresh();
              })
        ],
        backgroundColor: Colors.orange[800],
        title: Text(
          'Delivery Status',
        ),
        centerTitle: true,
      ),
      drawer: MerchantDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder(
          future: getPendingMerchantOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: SpinKitCircle(
                  color: Colors.orangeAccent,
                )),
              );
            } else {
              if (snapshot.data.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //mainAxisSize: MainAxisSize.max,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Center(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                      child: Text(
                        'No orders yet',
                        style: TextStyle(
                            fontSize: 40.0, color: Colors.orange[500]),
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: FancyButton(token: widget.token),
                    ),
                  ],
                );
              } else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                },
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          print(a[index]);
                                          // var authenticationToken =
                                          //     await getAuthToken();
                                          // http.delete(
                                          //     Uri.parse(
                                          //         'https://$httpLink//orders/merchant/delete_order/${snapshot.data[0]}'),
                                          //     headers: {
                                          //       "content-type":
                                          //           "application/json",
                                          //       "Authorization":
                                          //           "Token $authenticationToken"
                                          //     });
                                          setState(() {});
                                        }
                                        ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                        ),
                                        onPressed: () {
                                            Navigator.pushNamed(context, '/updateOrder');
                                        }),
                                  ],
                                ),
                                trailing: Text(
                                  "ID: ${snapshot.data[index].id.toString()}",
                                  style:
                                      TextStyle(backgroundColor: Colors.yellow),
                                ),
                                subtitle: Center(
                                    child: Text(
                                        'Driver: ${snapshot.data[index].driverName}')),
                                title: Card(
                                  color: Colors.orange,
                                  shadowColor: Colors.blue,
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data[index].city +
                                            ', ' +
                                            snapshot.data[index].street,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(snapshot
                                          .data[index].receiverFullName),
                                      Text(snapshot
                                          .data[index].receiverPhoneNumber),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    FancyButton(),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
