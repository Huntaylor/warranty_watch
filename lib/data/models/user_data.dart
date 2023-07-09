import 'dart:convert';

import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class UserData {
  UserData({
    required this.firstName,
    required this.lastName,
    required this.warranties,
    required this.email,
    required this.birthday,
  });
  final List<WarrantyInfo> warranties;
  final String email;
  final String firstName;
  final String lastName;
  final String birthday;

  factory UserData.fromJson(Map json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthday: json['birthday'],
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
      'birthday': birthday,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      warranties: List<WarrantyInfo>.from(map['warranties']?.map((x) => WarrantyInfo.fromMap(x))),
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      birthday: map['age'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
