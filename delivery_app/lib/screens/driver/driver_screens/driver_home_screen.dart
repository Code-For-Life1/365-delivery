import 'package:delivery_app/screens/driver/driver_pages/driver_order_history_page.dart';
import 'package:delivery_app/screens/driver/driver_pages/driver_receiving_new_order_page.dart';
import 'package:flutter/material.dart';

class DriverHomeScreen extends StatefulWidget {
  final String token;
  DriverHomeScreen({Key key, @required this.token}) : super(key: key);

  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    print("token inside is " + widget.token + '\n');
    _pageController.jumpToPage(selectedIndex);
    _currentIndex = selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [
          DriverReceivingOrder(token: widget.token),
          DriverOrderHistory(token: widget.token)
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
              Icons.assignment_outlined,
            ),
            label: 'Order History',
          ),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
