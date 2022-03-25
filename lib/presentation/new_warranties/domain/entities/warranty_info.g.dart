// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarrantyInfo _$WarrantyInfoFromJson(Map json) => WarrantyInfo(
      name: json['name'] as String?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      reminderDate: json['reminderDate'] == null
          ? null
          : DateTime.parse(json['reminderDate'] as String),
      warrWebsite: json['warrWebsite'] as String?,
      endOfWarr: json['endOfWarr'] == null
          ? null
          : DateTime.parse(json['endOfWarr'] as String),
      details: json['details'] as String?,
      image: json['image'] as String?,
      receiptImage: json['receiptImage'] as String?,
      lifeTime: json['lifeTime'] as bool? ?? false,
      isEditing: json['isEditing'] as bool? ?? false,
      wantsReminders: json['wantsReminders'] as bool? ?? false,
    );

Map<String, dynamic> _$WarrantyInfoToJson(WarrantyInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('purchaseDate', instance.purchaseDate?.toIso8601String());
  writeNotNull('warrWebsite', instance.warrWebsite);
  writeNotNull('endOfWarr', instance.endOfWarr?.toIso8601String());
  writeNotNull('reminderDate', instance.reminderDate?.toIso8601String());
  writeNotNull('details', instance.details);
  writeNotNull('image', instance.image);
  writeNotNull('receiptImage', instance.receiptImage);
  val['lifeTime'] = instance.lifeTime;
  val['isEditing'] = instance.isEditing;
  val['wantsReminders'] = instance.wantsReminders;
  return val;
}
