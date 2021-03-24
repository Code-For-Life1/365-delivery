// To parse this JSON data, do
//
//     final driverAuthentication = driverAuthenticationFromJson(jsonString);

import 'dart:convert';

DriverAuthentication driverAuthenticationFromJson(String str) => DriverAuthentication.fromJson(json.decode(str));

String driverAuthenticationToJson(DriverAuthentication data) => json.encode(data.toJson());

class DriverAuthentication {
  DriverAuthentication({
    this.token,
  });

  String token;

  factory DriverAuthentication.fromJson(Map<String, dynamic> json) => DriverAuthentication(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}