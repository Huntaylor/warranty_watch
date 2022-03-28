import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';

part 'warranty_info.g.dart';

@JsonSerializable()
class WarrantyInfo extends Equatable implements Serializable {
  final Key warrantyId;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrantyWebsite;
  final DateTime? endOfWarranty;
  final DateTime? reminderDate;
  final String? details;
  final String? image;
  final String? receiptImage;
  final bool lifeTime;
  final bool isEditing;
  final bool wantsReminders;
  WarrantyInfo({
    this.name,
    this.purchaseDate,
    this.reminderDate,
    this.warrantyWebsite,
    this.endOfWarranty,
    this.details,
    this.image,
    this.receiptImage,
    this.lifeTime = false,
    this.isEditing = false,
    this.wantsReminders = false,
  }) : warrantyId = UniqueKey();

  @override
  List<Object?> get props => [
        name,
        purchaseDate,
        endOfWarranty,
        warrantyWebsite,
        details,
        image,
        receiptImage,
        lifeTime,
        isEditing,
        warrantyId,
        wantsReminders,
        reminderDate,
      ];

  WarrantyInfo copyWith({
    String? name,
    DateTime? purchaseDate,
    DateTime? endOfWarranty,
    DateTime? reminderDate,
    String? warrantyWebsite,
    String? details,
    String? image,
    String? receiptImage,
    bool? lifeTime,
    bool? isEditing,
    bool? wantsReminders,
  }) {
    return WarrantyInfo._(
      reminderDate: reminderDate ?? this.reminderDate,
      wantsReminders: wantsReminders ?? this.wantsReminders,
      isEditing: isEditing ?? this.isEditing,
      warrantyId: warrantyId,
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
    this.reminderDate,
    this.name,
    this.purchaseDate,
    this.warrantyWebsite,
    this.endOfWarranty,
    this.details,
    this.image,
    this.receiptImage,
    required this.lifeTime,
    required this.isEditing,
    required this.warrantyId,
    required this.wantsReminders,
  });

  factory WarrantyInfo.fromJson(Map<String, dynamic> json, String warrantyId) =>
      _$WarrantyInfoFromJson({'warrantyId': warrantyId, ...json});

  @override
  Map<String, dynamic> toJson() => _$WarrantyInfoToJson(this);
}
