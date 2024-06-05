// To parse this JSON data, do
//
//     final registerModal = registerModalFromJson(jsonString);

import 'dart:convert';

RegisterModal registerModalFromJson(String str) =>
    RegisterModal.fromJson(json.decode(str));

String registerModalToJson(RegisterModal data) => json.encode(data.toJson());

class RegisterModal {
  final String? name;
  final String? address;
  final String? email;
  final String? password;
  final DateTime? date;

  RegisterModal({
    this.name,
    this.address,
    this.email,
    this.password,
    this.date,
  });

  factory RegisterModal.fromJson(Map<String, dynamic> json) => RegisterModal(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        password: json["password"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "password": password,
        "date": date?.toIso8601String(),
      };
      
  static List<RegisterModal>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => RegisterModal.fromJson(item)).toList();
  }

}
