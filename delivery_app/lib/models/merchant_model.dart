// To parse this JSON data, do
//
//     final merchantModel = merchantModelFromJson(jsonString);

import 'dart:convert';

MerchantModel merchantModelFromJson(String str) =>
    MerchantModel.fromJson(json.decode(str));

String merchantModelToJson(MerchantModel data) => json.encode(data.toJson());

class MerchantModel {
  MerchantModel({
    this.firstName,
    this.lastName,
    this.companyName,
    this.companyAddress,
    this.phoneNumber,
  });

  String firstName;
  String lastName;
  String companyName;
  String companyAddress;
  String phoneNumber;

  factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company_name": companyName,
        "company_address": companyAddress,
        "phone_number": phoneNumber,
      };
}
