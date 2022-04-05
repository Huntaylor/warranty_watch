import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:warranty_keeper/app_library.dart';

part 'warranty_info.g.dart';

enum WarrantyState { loading, initial, editing, submitted, loadingImage }

@JsonSerializable()
class WarrantyInfo extends Equatable implements Serializable {
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

  factory WarrantyInfo.fromJson(Map<String, dynamic> json, String warrantyId) =>
      _$WarrantyInfoFromJson({'warrantyId': warrantyId, ...json});

  @override
  Map<String, dynamic> toJson() => _$WarrantyInfoToJson(this);
}
