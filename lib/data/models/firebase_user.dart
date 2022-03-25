import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';

part 'firebase_user.g.dart';

@JsonSerializable()
class FirebaseUser extends Serializable with EquatableMixin {
  const FirebaseUser({
    required this.warrantyId,
    required this.name,
    required this.purchaseDate,
    required this.warrWebsite,
    required this.endOfWarr,
    required this.reminderDate,
    required this.details,
    required this.lifeTime,
    required this.isEditing,
    required this.wantsReminders,
  });
  final String warrantyId;
  final String? name;
  final DateTime? purchaseDate;
  final String? warrWebsite;
  final DateTime? endOfWarr;
  final DateTime? reminderDate;
  final String? details;
  final bool lifeTime;
  final bool isEditing;
  final bool wantsReminders;

  @override
  List<Object?> get props => [
        warrantyId,
        name,
        purchaseDate,
        warrWebsite,
        endOfWarr,
        reminderDate,
        details,
        lifeTime,
        isEditing,
        wantsReminders,
      ];

  factory FirebaseUser.fromJson(Map<String, dynamic> json, String userId) =>
      _$FirebaseUserFromJson({'userId': userId, ...json});

  @override
  Map<String, dynamic> toJson() => _$FirebaseUserToJson(this);
}

// extension FirebaseUserX on FirebaseUser {
//   WarrantyColletion get warranties {
//     return WarrantyColletion(userId!);
//   }
// }