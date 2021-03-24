import 'package:delivery_app/driver_add.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delivery_app/url_link.dart';


class MerchantDriversPage extends StatefulWidget {
  final String merchantID;
  MerchantDriversPage({Key key, @required this.merchantID}) : super(key: key);
  @override
  _MerchantDriversPageState createState() => _MerchantDriversPageState();
}

class _MerchantDriversPageState extends State<MerchantDriversPage> {

  Future<List<MerchantDrivers>> _getDrivers() async {
    //http://a84a794b3db6.ngrok.io/
    var uri = Uri(
      scheme: 'https',
      host: theLink,
      path: '/mydrivers/${widget.merchantID}',
    );
    assert(//http://f60fc987a44e.ngrok.io/
    uri.toString() == 'https://$theLink/mydrivers/${widget.merchantID}');
    var data = await http.get(uri);
    var jsonData = json.decode(data.body);
    List<MerchantDrivers> drivers = [];
    for(var u in jsonData){
      MerchantDrivers driver = MerchantDrivers(u["first_name"],u["last_name"],u["phone_number"]);
      drivers.add(driver);
    }
    print(drivers.length);
    return drivers;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: Text('Drivers'),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
        actions: [
         IconButton(icon: Icon(Icons.add), onPressed: (){
           Navigator.push(context, MaterialPageRoute(
               builder: (context) => DriverAdd()
           ));
         })
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getDrivers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(child: Text("Loading...")),
              );
            }
            else {
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
      )
    );
  }
}


class MerchantDrivers{
  final String firstName;
  final String lastName;
  final String phoneNumber;

  MerchantDrivers(this.firstName,this.lastName,this.phoneNumber);

}
