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

int orderCounter = 0;
Map<int, MerchantOrderDetailsModel> currentPlacedOrders = new Map();

class MerchantOrder extends StatefulWidget {
  final String token;
  MerchantOrder({Key key, @required this.token}) : super(key: key);

  @override
  _MerchantOrderState createState() => _MerchantOrderState();
}

class _MerchantOrderState extends State<MerchantOrder> {
  Future<List<MerchantOrderDetailsModel>> getPendingMerchantOrders() async {
    currentPlacedOrders.clear();
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
    orderCounter = jsonData.length - 1;
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
      currentPlacedOrders[orderCounter] = newOrder;
      orderCounter -= 1;
      orders.add(newOrder);
    }
    print(currentPlacedOrders.toString());
    return orders.reversed.toList();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          void _showDialog() {
                            // flutter defined function
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  title: new Text(
                                      "Are you sure you want to delete the order?"),
                                  content: new Text(
                                      "If you want to edit the order, press the edit button next to it."),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new TextButton(
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                Map<int,
                                                        MerchantOrderDetailsModel>
                                                    M = new Map();
                                                for (int k
                                                    in currentPlacedOrders
                                                        .keys) {
                                                  if (k != index) {
                                                    if (k > index) {
                                                      M[k - 1] =
                                                          currentPlacedOrders[
                                                              k];
                                                    } else {
                                                      M[k] =
                                                          currentPlacedOrders[
                                                              k];
                                                    }
                                                  }
                                                }
                                                var authenticationToken =
                                                    await getAuthToken();
                                                var uri = Uri(
                                                  scheme: 'http',
                                                  host: httpLink,
                                                  path:
                                                      '/orders/merchant/delete_order/' +
                                                          currentPlacedOrders[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                );
                                                print(uri.toString());
                                                var response =
                                                    http.delete(uri, headers: {
                                                  "content-type":
                                                      "application/json",
                                                  "Authorization":
                                                      "Token $authenticationToken"
                                                });
                                                currentPlacedOrders.clear();
                                                currentPlacedOrders =
                                                    Map.from(M);
                                                response.toString();
                                                print("new map = " +
                                                    currentPlacedOrders
                                                        .toString() +
                                                    '\n');
                                                setState(() {});
                                              },
                                              child: Text(
                                                'DELETE ORDER',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(fontSize: 16),
                                              ))
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          return Column(
                            children: [
                              ListTile(
                                onTap: () {},
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          _showDialog();
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                        ),
                                        onPressed: () {
                                          print(currentPlacedOrders[index]);
                                          Navigator.pushNamed(
                                              context, '/updateOrder',
                                              arguments: {
                                                'id': currentPlacedOrders[index]
                                                    .id,
                                                'receiver_full_name':
                                                    currentPlacedOrders[index]
                                                        .receiverFullName,
                                                'receiver_phone_number':
                                                    currentPlacedOrders[index]
                                                        .receiverPhoneNumber,
                                                'street':
                                                    currentPlacedOrders[index]
                                                        .street,
                                                'building':
                                                    currentPlacedOrders[index]
                                                        .building,
                                                'city':
                                                    currentPlacedOrders[index]
                                                        .city,
                                                'floor':
                                                    currentPlacedOrders[index]
                                                        .floor,
                                                'driver_name':
                                                    currentPlacedOrders[index]
                                                        .driverName
                                              });
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
