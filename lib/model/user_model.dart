import 'dart:convert';

import 'address_model.dart';
import 'company_model.dart';

class UserModel {
  UserModel(
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  );

  late int id;
  late String name;
  late String username;
  late String email;
  late Address address;
  late String phone;
  late String website;
  late Company company;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    address = Address.fromJson(json["address"]);
    phone = json["phone"];
    website = json["website"];
    company = Company.fromJson(json["company"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toMap(),
        "phone": phone,
        "website": website,
        "company": company.toMap(),
      };
}
