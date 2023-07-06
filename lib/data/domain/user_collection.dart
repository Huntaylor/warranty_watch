import 'package:firebase_auth/firebase_auth.dart';
import 'package:firefuel/firefuel.dart';

import 'package:warranty_keeper/data/models/firebase_user.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class UserCollection extends FirefuelCollection<FirebaseUser> {
  UserCollection() : super('users');
  DocumentId get currentUserDocId =>
      DocumentId(FirebaseAuth.instance.currentUser!.uid);

  @override
  FirebaseUser? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return data == null ? null : FirebaseUser.fromJson(data, snapshot.id);
  }

  @override
  Map<String, Object?> toFirestore(FirebaseUser? model, SetOptions? options) {
    return model?.toJson() ?? <String, Object>{};
  }
}

class WarrantyCollection extends FirefuelCollection<WarrantyInfo> {
  WarrantyCollection()
      : super('users/${FirebaseAuth.instance.currentUser!.uid}/$name');

  static const String name = 'warranties';

  static String productUrlPath(
          {required String warrantyId, required String imagePath}) =>
      '${WarrantyCollection().path}/$name/$warrantyId/product';

  static String receiptUrlPath(
          {required String warrantyId, required String imagePath}) =>
      '${WarrantyCollection().path}/$name/$warrantyId/receipt';

  @override
  WarrantyInfo? fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return data == null ? null : WarrantyInfo.fromJson(data, snapshot.id);
  }

  @override
  Map<String, Object?> toFirestore(WarrantyInfo? model, SetOptions? options) {
    return model?.toJson() ?? <String, Object>{};
  }
}
