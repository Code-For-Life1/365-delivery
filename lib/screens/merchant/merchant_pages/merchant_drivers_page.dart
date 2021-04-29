import 'package:delivery_app/customWidgets/merchant_drawer.dart';
import 'package:delivery_app/models/merchant_drivers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../notifications.dart';

var phoneNumber;

class MerchantDriversPage extends StatefulWidget {
  final String token;
  MerchantDriversPage({Key key, @required this.token}) : super(key: key);
  @override
  _MerchantDriversPageState createState() => _MerchantDriversPageState();
}

class _MerchantDriversPageState extends State<MerchantDriversPage> {
  List<MerchantDrivers> driversDisplayed = [];
  Future<List<MerchantDrivers>> _getDrivers() async {
    var uri = Uri(
      scheme: 'https',
      host: httpLink,
      path: '/users/merchant/drivers',
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String T = prefs.getString('token');
    var data = await http.get(uri, headers: {
      "content-type": "application/json",
      "Authorization": "Token " + T
    });

    var jsonData = json.decode(data.body);
    List<MerchantDrivers> drivers = [];
    for (var eachDriver in jsonData) {
      MerchantDrivers driver = MerchantDrivers(eachDriver["first_name"],
          eachDriver["last_name"], eachDriver["phone_number"]);
      phoneNumber = eachDriver['phone_number'];

      drivers.add(driver);
    }
    print(drivers.length);
    driversDisplayed = drivers;
    return drivers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/driverAdd', arguments: widget.token);
          },
        ),
        drawer: MerchantDrawer(),
        appBar: AppBar(
          title: Text('My Drivers'),
          centerTitle: true,
          backgroundColor: Colors.orange[800],
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                })
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: _getDrivers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                      child: SpinKitCircle(
                    color: Colors.orangeAccent,
                  )),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    String selectedDriverPhoneNumber =
                        driversDisplayed[index].phoneNumber;
                    void _showDialog() {
                      // flutter defined function
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text(
                                "Are you sure you want to remove this driver?"),
                            content: new Text(
                                "You will have to register the driver again"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new TextButton(
                                child: Row(
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);

                                          Map phoneNumberToBeDeleted = {
                                            'phone_number':
                                                selectedDriverPhoneNumber
                                          };
                                          var authenticationToken =
                                              await getAuthToken();
                                          var encodedPhoneNumber = json
                                              .encode(phoneNumberToBeDeleted);
                                          await http.delete(
                                              Uri.parse(
                                                  'https://$httpLink/users/merchant/delete_driver'),
                                              body: encodedPhoneNumber,
                                              headers: {
                                                "content-type":
                                                    "application/json",
                                                "Authorization":
                                                    "Token $authenticationToken"
                                              });

                                          setState(() {});
                                        },
                                        child: Text(
                                          'REMOVE DRIVER',
                                          style: TextStyle(color: Colors.red),
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

                    return Card(
                      color: Colors.orange,
                      shadowColor: Colors.blue,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/portrait.png'),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data[index].firstName +
                                ' ' +
                                snapshot.data[index].lastName),
                            TextButton(
                                onPressed: () {
                                  _showDialog();
                                },
                                child: Text(
                                  'REMOVE DRIVER',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ))
                          ],
                        ),
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
