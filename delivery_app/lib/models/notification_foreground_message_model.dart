import 'package:flutter/material.dart';

@immutable
class NotificationMessageModel {
  final String title;
  final String body;

  const NotificationMessageModel({
    @required this.title,
    @required this.body,
  });
}