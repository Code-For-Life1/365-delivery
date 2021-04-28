// To parse this JSON data, do
//
//     final driverModel = driverModelFromJson(jsonString);

import 'dart:convert';

DriverModel driverModelFromJson(String str) =>
    DriverModel.fromJson(json.decode(str));

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
  DriverModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  String firstName;
  String lastName;
  String phoneNumber;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
      };
}
