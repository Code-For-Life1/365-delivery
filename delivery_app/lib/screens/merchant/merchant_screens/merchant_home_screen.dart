import 'package:delivery_app/screens/merchant/merchant_pages/merchant_drivers_page.dart';
import 'package:delivery_app/screens/merchant/merchant_pages/merchant_order_page.dart';
import 'package:flutter/material.dart';
import 'merchant_orders_history_screen.dart';

class MerchantHomeScreen extends StatefulWidget {
  final String token;
  MerchantHomeScreen({Key key, @required this.token}) : super(key: key);

  @override
  _MerchantHomeScreenState createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {

  int _currentIndex = 0;
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    print(widget.token);
    _pageController.jumpToPage(selectedIndex);
    _currentIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
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
        children: <Widget>[
          MerchantOrder(token:widget.token),
          MerchantDriversPage(token: widget.token),
          MerchantOrdersHistory(token: widget.token)
        ],
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
            label: 'Drivers',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Orders'
          )
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
