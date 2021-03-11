

import 'package:delivery_app/customWidgets/FancyButton.dart';
import 'package:delivery_app/merchant_drivers.dart';
import 'package:delivery_app/merchant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MerchantOrder extends StatefulWidget {
  @override
  _MerchantOrderState createState() => _MerchantOrderState();
}

class _MerchantOrderState extends State<MerchantOrder> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [MerchantOrder2(), MerchantDrivers()];
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
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.orange[800],
        title: Text(
          'Delivery Status',
        ),
        centerTitle: true,
      ),
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
            label: 'Drivers',
          )
        ],
      onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
