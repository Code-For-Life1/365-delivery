import 'package:delivery_app/merchant_drivers.dart';
import 'package:delivery_app/merchant_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MerchantHomePage extends StatefulWidget {
  final String merchantID;
  MerchantHomePage({Key key, @required this.merchantID}) : super(key: key);


  @override
  _MerchantHomePageState createState() => _MerchantHomePageState();
}






class _MerchantHomePageState extends State<MerchantHomePage> {


  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screens = [MerchantOrder(), MerchantDriversPage()];
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
    print(widget.merchantID);
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
            label: 'Drivers',
          )
        ],
      onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
      ),
    );
  }
}
