import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:delivery_app/url_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/notification_model.dart';
import 'screens/driver/driver_screens/driver_home_screen.dart';
import 'screens/merchant/merchant_screens/merchant_home_screen.dart';
import 'package:http/http.dart' as http;

String uniqueNotificationToken;

Map<String, String> getNotificationBody(String uniqueToken) {
  return {
    "registration_id": uniqueNotificationToken,
    "type": "android",
  };
}

Future<void> method1() async {
  // Get the token each time the application loads
  uniqueNotificationToken = await FirebaseMessaging.instance.getToken();
  print("uniqueNotificationToken is $uniqueNotificationToken");

  NotificationModel _newNotModel = new NotificationModel(
      notificationToken: uniqueNotificationToken, deviceType: "android");

  // Save the initial token to the database
  await saveTokenToDatabase(uniqueNotificationToken);

  // Any time the token refreshes, store this in the database too.
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

}

void deleteNotificationToken(){
  FirebaseMessaging.instance.deleteToken();
  uniqueNotificationToken = null;
}


Future<void> saveTokenToDatabase(String token) async {
  Map<String, String> notificationBody =
      getNotificationBody(uniqueNotificationToken);
  var jsonData = json.encode(notificationBody);
  //need to check if there is login token, if yes update notification token to database
  http.post(Uri.parse('http://$ngrokLink/users/fcm/add_device'),
      body: jsonData,
      headers: {
        "content-type": "application/json",
        "Authorization": "Token d9459e42eeb0d7951a0bc6c312a160537cc46035"
      });
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
  print('Initialized default app $app');
}


Future<String> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String T = prefs.getString('token');
  return T == null ? "" : T;
}