
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String uniqueNotificationToken;

Map<String, String> getNotificationBody(String uniqueToken) {
  return {
    "registration_id": uniqueNotificationToken,
    "type": "android",
  };
}
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Create a [AndroidNotificationChannel] for heads up notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

Future<void> notificationHandler() async {
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
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   // RemoteNotification notification = message.notification;
  //   // AndroidNotification android = message.notification?.android;
  //   // var androidDetails = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
  //   // var iosDetails = IOSNotificationDetails();
  //   // var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);
  //
  //   // If `onMessage` is triggered with a notification, construct our own
  //   // local notification to show to users using the created channel.
  //   // if (notification != null && android != null) {
  //   //   flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, generalNotificationDetails);
  //   //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   //   var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   //   var iosInit = IOSInitializationSettings();
  //   //   var initSetting = InitializationSettings(android: androidInit,iOS: iosInit);
  //   //   flutterLocalNotificationsPlugin.initialize(initSetting);
  //   //
  //   // } else
  //   //   print('nothing');
  //
  // });
  FirebaseMessaging.onBackgroundMessage((message) => null);
  //Foreground notification
}

// void foregroundNotify() {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification notification = message.notification;
//     AndroidNotification android = message.notification?.android;
//     var androidDetails = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
//     var iosDetails = IOSNotificationDetails();
//     var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);
//
//     // If `onMessage` is triggered with a notification, construct our own
//     // local notification to show to users using the created channel.
//     if (notification != null && android != null) {
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//       flutterLocalNotificationsPlugin.show(0, 'title', 'body', generalNotificationDetails);
//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//       var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//       var iosInit = IOSInitializationSettings();
//       var initSetting = InitializationSettings(android: androidInit,iOS: iosInit);
//       flutterLocalNotificationsPlugin.initialize(initSetting);
//
//     } else
//       print('nothing');
//   });
// }

void deleteNotificationToken() {
  FirebaseMessaging.instance.deleteToken();
  uniqueNotificationToken = null;
}

Future<void> saveTokenToDatabase(String token) async {
  Map<String, String> notificationBody =
      getNotificationBody(uniqueNotificationToken);
  var jsonData = json.encode(notificationBody);
  //need to check if there is login token, if yes update notification token to database
  var authenticationToken = await getAuthToken();
  authenticationToken == ""
      ? throw Exception("Authentication Token is null")
      : http.post(Uri.parse('https://$httpLink/users/fcm/add_device'),
          body: jsonData,
          headers: {
              "content-type": "application/json",
              "Authorization": "Token $authenticationToken"
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
