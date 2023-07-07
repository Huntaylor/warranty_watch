import 'dart:convert';

import 'package:warranty_keeper/app_library.dart';

enum WarrantyState { loading, initial, editing, submitted, loadingImage }

class WarrantyInfo extends Equatable {
  final WarrantyState warrantyState;
  final String warrantyId;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrantyWebsite;
  final DateTime? endOfWarranty;
  final DateTime? reminderDate;
  final String? details;
  final String? image;
  final String? imageUrl;
  final String? receiptImage;
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

  WarrantyInfo copyWith({
    String? warrantyId,
    String? name,
    DateTime? purchaseDate,
    DateTime? endOfWarranty,
    DateTime? reminderDate,
    String? warrantyWebsite,
    String? details,
    String? receiptImageUrl,
    String? imageUrl,
    String? image,
    String? receiptImage,
    bool? lifeTime,
    bool? wantsReminders,
    WarrantyState? warrantyState,
  }) {
    return WarrantyInfo._(
      imageUrl: imageUrl ?? this.imageUrl,
      receiptImageUrl: receiptImageUrl ?? this.receiptImageUrl,
      warrantyState: warrantyState ?? this.warrantyState,
      reminderDate: reminderDate ?? this.reminderDate,
      wantsReminders: wantsReminders ?? this.wantsReminders,
      warrantyId: warrantyId ?? this.warrantyId,
      name: name ?? this.name,
      purchaseDate: purchaseDate ?? DateTime.now(),
      endOfWarranty: endOfWarranty ?? this.endOfWarranty,
      warrantyWebsite: warrantyWebsite ?? this.warrantyWebsite,
      details: details ?? this.details,
      image: image ?? this.image,
      receiptImage: receiptImage ?? this.receiptImage,
      lifeTime: lifeTime ?? this.lifeTime,
    );
  }

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
    if (purchaseDate == null) return false;
    if (warrantyWebsite == 'https://' || warrantyWebsite == null) return false;
    if (image == null) return false;
    if (endOfWarranty == null && lifeTime != true) return false;
    return true;
  }

  const WarrantyInfo._({
    this.imageUrl,
    this.receiptImageUrl,
    this.reminderDate,
    this.name,
    this.purchaseDate,
    this.warrantyWebsite,
    this.endOfWarranty,
    this.details,
    this.image,
    this.receiptImage,
    required this.warrantyState,
    required this.lifeTime,
    required this.warrantyId,
    required this.wantsReminders,
  });

  Map<String, dynamic> toMap() {
    return {
      'warrantyState': warrantyState,
      'warrantyId': warrantyId,
      'name': name,
      'purchaseDate': purchaseDate?.millisecondsSinceEpoch,
      'warrantyWebsite': warrantyWebsite,
      'endOfWarranty': endOfWarranty?.millisecondsSinceEpoch,
      'reminderDate': reminderDate?.millisecondsSinceEpoch,
      'details': details,
      'image': image,
      'imageUrl': imageUrl,
      'receiptImage': receiptImage,
      'receiptImageUrl': receiptImageUrl,
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
