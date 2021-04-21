import 'package:delivery_app/customWidgets/loading_screen.dart';
import 'package:delivery_app/screens/driver/driver_screens/driver_home_screen.dart';
import 'package:delivery_app/screens/merchant/merchant_screens/merchant_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivery_app/screens/welcome.dart';
import 'package:delivery_app/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault(); //do not touch this
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String role  = prefs.getString('role');
  print(token);
  runApp(MaterialApp(
    home: token == null ? MyApp() : role == 'driver' ? DriverHomeScreen(token: token) : MerchantHomeScreen(token: token),
    initialRoute: token == null ? '/' : role == 'driver' ? '/driverHomeScreen' : '/merchantHomeScreen',
    routes: {
      '/driverHomeScreen': (context) => DriverHomeScreen(token: token),
      '/merchantHomeScreen': (context) => MerchantHomeScreen(token: token)
    },
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}



// void main() => runApp(MyApp1());
//
// class MyApp1 extends StatelessWidget {
//   final String appTitle = 'Firebase messaging';
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: appTitle,
//     home: MainPage(appTitle: appTitle),
//   );
// }
//
// class MainPage extends StatelessWidget {
//   final String appTitle;
//
//   const MainPage({this.appTitle});
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: SignInLoadingScreen(),
//   );
// }














//original



// Future<void> main() async {
//   await method1();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString('token');
//   String role  = prefs.getString('role');
//   print(token);
//   runApp(MaterialApp(
//     home: token == null ? MyApp() : role == 'driver' ? DriverHomeScreen(token: token) : MerchantHomeScreen(token: token),
//     initialRoute: token == null ? '/' : role == 'driver' ? '/driverHomeScreen' : '/merchantHomeScreen',
//     routes: {
//       '/driverHomeScreen': (context) => DriverHomeScreen(token: token),
//       '/merchantHomeScreen': (context) => MerchantHomeScreen(token: token)
//     },
//     onGenerateRoute: RouteGenerator.generateRoute,
//     debugShowCheckedModeBanner: false,
//   ));
// }
