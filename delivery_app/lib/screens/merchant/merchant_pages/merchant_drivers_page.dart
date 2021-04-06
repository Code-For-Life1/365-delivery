import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:delivery_app/models/merchant_drivers_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';

class MerchantDriversPage extends StatefulWidget {
  final String token;
  MerchantDriversPage({Key key, @required this.token}) : super(key: key);
  @override
  _MerchantDriversPageState createState() => _MerchantDriversPageState();
}

class _MerchantDriversPageState extends State<MerchantDriversPage> {
  Future<List<MerchantDrivers>> _getDrivers() async {
    var uri = Uri(
      scheme: 'https',
      host: ngrokLink,
      path: '/users/merchant/drivers/',
    );
    var data = await http.get(uri, headers: {"content-type": "application/json", "Authorization": "Token " + widget.token});
    var jsonData = json.decode(data.body);
    List<MerchantDrivers> drivers = [];
    for (var u in jsonData) {
      MerchantDrivers driver = MerchantDrivers(u["first_name"], u["last_name"], u["phone_number"]);
      drivers.add(driver);
    }
    print(drivers.length);
    return drivers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MerchantDrawer(),
        appBar: AppBar(
          title: Text('My Drivers'),
          centerTitle: true,
          backgroundColor: Colors.orange[800],
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/driverAdd', arguments: widget.token);
                })
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: _getDrivers(),
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
                      child: ListTile(
                        leading: Text(snapshot.data[index].lastName),
                        title: Text(snapshot.data[index].firstName),
                        subtitle: Text(snapshot.data[index].phoneNumber),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
