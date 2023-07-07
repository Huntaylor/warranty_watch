import 'dart:convert';

import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class UserData {
  UserData({
    required this.firstName,
    required this.lastName,
    required this.warranties,
    required this.email,
    required this.age,
  });
  final List<WarrantyInfo> warranties;
  final String email;
  final String firstName;
  final String lastName;
  final String age;

  factory UserData.fromJson(Map json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      warranties: json['warranties'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'warranties': warranties.map((x) => x.toMap()).toList(),
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      warranties: List<WarrantyInfo>.from(map['warranties']?.map((x) => WarrantyInfo.fromMap(x))),
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
