import 'package:delivery_app/screens/driver/driver_screens/driver_home_screen.dart';
import 'package:delivery_app/screens/merchant/merchant_screens/merchant_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivery_app/screens/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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