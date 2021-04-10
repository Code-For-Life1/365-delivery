import 'package:delivery_app/customWidgets/new_order_button.dart';
import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MerchantOrder extends StatefulWidget {
  final String token;
  @override
  MerchantOrder({Key key, @required this.token}): super(key: key);
  _MerchantOrderState createState() => _MerchantOrderState();
}

class _MerchantOrderState extends State<MerchantOrder> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          Center(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 250, 0, 250),
            child: Text(
              'No orders yet',
              style: TextStyle(fontSize: 40.0, color: Colors.orange[500]),
            ),
          )),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: FancyButton(token: widget.token)
          ),
        ],
      ),
    );
  }
}
