import 'package:delivery_app/driver_add.dart';
import 'package:delivery_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';


class Orders_Placed extends StatefulWidget {
  @override
  _Orders_Placed createState() => _Orders_Placed();
}

class _Orders_Placed extends State<Orders_Placed> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Order History"),
    );
  }
}