// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarrantyInfo _$WarrantyInfoFromJson(Map json) => WarrantyInfo(
      warrantyId: json['warrantyId'] as String,
      warrantyState:
          $enumDecodeNullable(_$WarrantyStateEnumMap, json['warrantyState']) ??
              WarrantyState.initial,
      name: json['name'] as String?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      warrantyWebsite: json['warrantyWebsite'] as String?,
      endOfWarranty: json['endOfWarranty'] == null
          ? null
          : DateTime.parse(json['endOfWarranty'] as String),
      reminderDate: json['reminderDate'] == null
          ? null
          : DateTime.parse(json['reminderDate'] as String),
      details: json['details'] as String?,
      image: json['image'] as String?,
      imageUrl: json['imageUrl'] as String?,
      receiptImage: json['receiptImage'] as String?,
      receiptImageUrl: json['receiptImageUrl'] as String?,
      lifeTime: json['lifeTime'] as bool? ?? false,
      wantsReminders: json['wantsReminders'] as bool? ?? false,
    );

Map<String, dynamic> _$WarrantyInfoToJson(WarrantyInfo instance) {
  final val = <String, dynamic>{
    'warrantyState': _$WarrantyStateEnumMap[instance.warrantyState],
    'warrantyId': instance.warrantyId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('purchaseDate', instance.purchaseDate?.toIso8601String());
  writeNotNull('warrantyWebsite', instance.warrantyWebsite);
  writeNotNull('endOfWarranty', instance.endOfWarranty?.toIso8601String());
  writeNotNull('reminderDate', instance.reminderDate?.toIso8601String());
  writeNotNull('details', instance.details);
  writeNotNull('image', instance.image);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('receiptImage', instance.receiptImage);
  writeNotNull('receiptImageUrl', instance.receiptImageUrl);
  val['lifeTime'] = instance.lifeTime;
  val['wantsReminders'] = instance.wantsReminders;
  return val;
}

const _$WarrantyStateEnumMap = {
  WarrantyState.loading: 'loading',
  WarrantyState.initial: 'initial',
  WarrantyState.editing: 'editing',
  WarrantyState.submitted: 'submitted',
};
