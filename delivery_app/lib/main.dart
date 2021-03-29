import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/route_generator.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ));
