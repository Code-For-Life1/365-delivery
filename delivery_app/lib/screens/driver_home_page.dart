import 'package:delivery_app/driver_receiving_order.dart';
import 'package:delivery_app/merchant_drivers.dart';
import 'package:delivery_app/merchant_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  final String driverID;
  DriverHomePage({Key key, @required this.driverID}) : super(key: key);


  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}



class _DriverHomePageState extends State<DriverHomePage> {


  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [DriverReceivingOrder(), MerchantDriversPage()];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
    _currentIndex = selectedIndex;
  }



  @override
  Widget build(BuildContext context) {
    print(widget.driverID);
    // final String data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Hello')),
            ListTile(title: Text('A')),
            ListTile(title: Text('B')),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.delivery_dining,
            ),
            label: 'Example',
          )
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
