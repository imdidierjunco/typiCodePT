import 'dart:convert';

import 'address_model.dart';
import 'company_model.dart';

//User userModelFromMap(String str) => User.fromMap(json.decode(str));

//String userModelToMap(User data) => json.encode(data.toMap());

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.company,
  });

  int id = 0;
  String name = '';
  String email = '';
  Address address = {
    '': '',
  } as Address;
  Company company = {'': ''} as Company;

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    address = Address.fromJson(json["address"]);
    company = Company.fromJson(json["company"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address.toMap(),
        "company": company.toMap(),
      };

  static fromJsonList(dataDecoded) {}
}
