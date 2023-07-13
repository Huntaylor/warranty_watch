import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';

part 'warranty_info.g.dart';

enum WarrantyState { loading, initial, editing, submitted, loadingImage }

@CopyWith()
class WarrantyInfo extends Equatable {
  final WarrantyState warrantyState;
  final String warrantyId;
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
    required this.warrantyId,
    this.warrantyState = WarrantyState.initial,
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
  List<Object?> get props => [
        name,
        purchaseDate,
        endOfWarranty,
        warrantyWebsite,
        imageUrl,
        receiptImageUrl,
        details,
        image,
        receiptImage,
        lifeTime,
        warrantyId,
        wantsReminders,
        reminderDate,
        warrantyState,
      ];

  // factory WarrantyInfo.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return WarrantyInfo(
  //     name: data?['name'],
  //     imagesList: data?['imagesList'],
  //     purchaseDate: data?['purchaseDate'],
  //     endOfWarr: data?['endOfWarr'],
  //     reminderDate: data?['reminderDate'],
  //     warrWebsite: data?['warrWebsite'],
  //     details: data?['details'],
  //     image: data?['image'],
  //     receiptImage: data?['receiptImage'],
  //     lifeTime: data?['lifeTime'],
  //     isEditing: data?['isEditing'],
  //     wantsReminders: data?['wantsReminders'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (name != null) "name": name,
  //     if (imagesList != null) "imagesList": imagesList,
  //     if (purchaseDate != null) "purchaseDate": purchaseDate,
  //     if (endOfWarr != null) "endOfWarr": endOfWarr,
  //     if (reminderDate != null) "reminderDate": reminderDate,
  //     if (warrWebsite != null) "warrWebsite": warrWebsite,
  //     if (details != null) "details": details,
  //     if (image != null) "image": image,
  //     if (receiptImage != null) "receiptImage": receiptImage,
  //     "lifeTime": lifeTime,
  //     "isEditing": isEditing,
  //     "wantsReminders": wantsReminders,
  //   };
  // }

  bool canSave() {
    if (name == null) return false;
    if (name!.isEmpty) return false;
    if (endOfWarranty == null && lifeTime != true) return false;
    return true;
  }

  Map<String, dynamic> toMap({final String? newImageUrl, final String? newReceiptImageUrl, final String? warrantyUUID}) {
    return {
      'warrantyId': warrantyUUID,
      'name': name,
      'purchaseDate': purchaseDate?.millisecondsSinceEpoch,
      'warrantyWebsite': warrantyWebsite,
      'endOfWarranty': endOfWarranty?.millisecondsSinceEpoch,
      'reminderDate': reminderDate?.millisecondsSinceEpoch,
      'details': details,
      'imageUrl': newImageUrl ?? imageUrl,
      'receiptImageUrl': newReceiptImageUrl ?? receiptImageUrl,
      'lifeTime': lifeTime,
      'wantsReminders': wantsReminders,
    };
  }

  factory WarrantyInfo.fromMap(Map<String, dynamic> map) {
    return WarrantyInfo(
      warrantyState: map['warrantyState'],
      warrantyId: map['warrantyId'] ?? '',
      name: map['name'],
      purchaseDate: map['purchaseDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['purchaseDate']) : null,
      warrantyWebsite: map['warrantyWebsite'],
      endOfWarranty: map['endOfWarranty'] != null ? DateTime.fromMillisecondsSinceEpoch(map['endOfWarranty']) : null,
      reminderDate: map['reminderDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['reminderDate']) : null,
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

  factory WarrantyInfo.fromJson(String source) => WarrantyInfo.fromMap(json.decode(source));
}
