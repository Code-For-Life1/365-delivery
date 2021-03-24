import 'package:delivery_app/driver_receiving_order.dart';
import 'package:delivery_app/merchant_home_page.dart';
import 'package:delivery_app/screens/driver_home_page.dart';
import 'package:delivery_app/test_screens/test3.dart';
import 'test_screens/test1.dart';
import 'test_screens/test2.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/welcome.dart';
import 'screens/driver_sign_up.dart';
import 'screens/merchant_sign_up.dart';
import 'screens/driver_sign_in.dart';
import 'screens/merchant_sign_in.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/driverSignUpScreen':
        return MaterialPageRoute(builder: (_) => DriverSignUp());
      case '/merchantSignUpScreen':
        return MaterialPageRoute(builder: (_)=>MerchantSignUp());
      case '/driverSignInScreen':
        return MaterialPageRoute(builder: (_)=>DriverSignIn());
      case '/merchantSignInScreen':
        return MaterialPageRoute(builder: (_)=>MerchantSignIn());
      case '/driverHomePage':
        return MaterialPageRoute(builder: (_)=>DriverHomePage());
      case '/merchantHomePage':
        return MaterialPageRoute(builder: (_)=>MerchantHomePage(merchantID :args));
      case '/driverReceivingOrder':
        return MaterialPageRoute(builder: (_)=>DriverReceivingOrder());
      case '/test1':
        return MaterialPageRoute(builder: (_)=>Test());
      case '/test2':
        return MaterialPageRoute(builder: (_)=>Test2());
      case '/test3':
        return MaterialPageRoute(builder: (_)=>Test3());
      default:
        //if there is no such named route in the switch statement, e.g /third
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("Error"),
            ),
          );
        }
    );
  }
}
