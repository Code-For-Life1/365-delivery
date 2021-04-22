import 'package:flutter/material.dart';

@immutable
class NotificationModel {
  final String notificationToken;
  final String deviceType;

  const NotificationModel({@required this.notificationToken,@required this.deviceType});
}
