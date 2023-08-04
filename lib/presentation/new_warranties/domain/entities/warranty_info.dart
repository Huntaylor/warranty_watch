import 'dart:convert';

import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';

part 'warranty_info.g.dart';

@CopyWith()
@autoequal
class WarrantyInfo extends Equatable {
  final String id;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrantyWebsite;
  final DateTime? endOfWarranty;
  final DateTime? reminderDate;
  final String? details;
  final XFile? image;
  final String? imageUrl;
  final XFile? receiptImage;
  final String? receiptImageUrl;
  final bool lifeTime;
  final bool wantsReminders;
  const WarrantyInfo({
    required this.id,
    this.name,
    this.purchaseDate,
    this.warrantyWebsite,
    this.endOfWarranty,
    this.reminderDate,
    this.details,
    this.image,
    this.imageUrl,
    this.receiptImage,
    this.receiptImageUrl,
    this.lifeTime = false,
    this.wantsReminders = false,
  });

  @override
  List<Object?> get props => _$props;

  bool canSave() {
    if (name == null) return false;
    if (name!.isEmpty) return false;
    if (endOfWarranty == null && lifeTime != true) return false;
    return true;
  }

  Map<String, dynamic> toMap() {
    return {
      'warrantyId': id,
      'name': name,
      'purchaseDate': purchaseDate?.millisecondsSinceEpoch,
      'warrantyWebsite': warrantyWebsite,
      'endOfWarranty': endOfWarranty?.millisecondsSinceEpoch,
      'reminderDate': reminderDate?.millisecondsSinceEpoch,
      'details': details,
      'imageUrl': imageUrl,
      'receiptImageUrl': receiptImageUrl,
      'lifeTime': lifeTime,
      'wantsReminders': wantsReminders,
    };
  }

  factory WarrantyInfo.fromMap(Map<String, dynamic> map) {
    return WarrantyInfo(
      id: map['warrantyId'] ?? '',
      name: map['name'],
      purchaseDate: map['purchaseDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['purchaseDate'],
            )
          : null,
      warrantyWebsite: map['warrantyWebsite'],
      endOfWarranty: map['endOfWarranty'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['endOfWarranty'],
            )
          : null,
      reminderDate: map['reminderDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['reminderDate'],
            )
          : null,
      details: map['details'],
      image: map['image'],
      imageUrl: map['imageUrl'],
      receiptImage: map['receiptImage'],
      receiptImageUrl: map['receiptImageUrl'],
      lifeTime: map['lifeTime'] ?? false,
      wantsReminders: map['wantsReminders'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyInfo.fromJson(String source) =>
      WarrantyInfo.fromMap(json.decode(source));
}
