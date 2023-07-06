// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseUser _$FirebaseUserFromJson(Map json) => FirebaseUser(
      warrantyId: json['warrantyId'] as String,
      name: json['name'] as String?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      warrWebsite: json['warrWebsite'] as String?,
      endOfWarr: json['endOfWarr'] == null
          ? null
          : DateTime.parse(json['endOfWarr'] as String),
      reminderDate: json['reminderDate'] == null
          ? null
          : DateTime.parse(json['reminderDate'] as String),
      details: json['details'] as String?,
      lifeTime: json['lifeTime'] as bool,
      isEditing: json['isEditing'] as bool,
      wantsReminders: json['wantsReminders'] as bool,
    );

Map<String, dynamic> _$FirebaseUserToJson(FirebaseUser instance) {
  final val = <String, dynamic>{
    'warrantyId': instance.warrantyId,
  };

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
  val['lifeTime'] = instance.lifeTime;
  val['isEditing'] = instance.isEditing;
  val['wantsReminders'] = instance.wantsReminders;
  return val;
}
