import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:uuid/uuid.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

abstract class WarrantyRepository {
  Future<void> submitWarranty(WarrantyInfo warrantyInfo);
  Future<void> editWarranty(WarrantyInfo warrantyInfo);
  Future<void> deleteWarranty(WarrantyInfo warrantyInfo);
  Future<void> getAll();
  Future<void> getById();
}

class FirebaseDataRepository implements WarrantyRepository {
  FirebaseStorage storage = FirebaseStorage.instance;
  final firebaseauth.FirebaseAuth _auth = firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> editWarranty(WarrantyInfo warrantyInfo) {
    // TODO: implement editWarranty
    throw UnimplementedError();
  }

  @override
  Future<void> submitWarranty(WarrantyInfo warrantyInfo) async {
    final String downloadImageUrl;
    final String downloadReceiptUrl;
    final warrantyUuid = const Uuid().v1();
    try {
      final currentUser = _auth.currentUser!.uid;
      final referenceProduct = storage.ref('users/$currentUser/warrantyImages/products').child('${warrantyInfo.name}');
      final referenceReceipts = storage.ref('users/$currentUser/warrantyImages/receipts').child('${warrantyInfo.name}');

      if (warrantyInfo.image != null) {
        final imageTask = referenceProduct.putFile(File(warrantyInfo.image!.path));

        final snapshot = await imageTask.whenComplete(() {});
        downloadImageUrl = await snapshot.ref.getDownloadURL();
      } else {
        downloadImageUrl = '';
      }
      if (warrantyInfo.receiptImage != null) {
        final receiptTask = referenceReceipts.putFile(File(warrantyInfo.receiptImage!.path));

        final snapshot = await receiptTask.whenComplete(() {});
        downloadReceiptUrl = await snapshot.ref.getDownloadURL();
      } else {
        downloadReceiptUrl = '';
      }

      await users.doc(currentUser).collection('warranties').doc(warrantyInfo.name).set(
            warrantyInfo.toMap(
              newImageUrl: downloadImageUrl,
              newReceiptImageUrl: downloadReceiptUrl,
              warrantyUUID: warrantyUuid,
            ),
          );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> getAll() {
    // TODO: implement getWarranties
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWarranty(WarrantyInfo warrantyInfo) {
    // TODO: implement deleteWarranty
    throw UnimplementedError();
  }

  @override
  Future<void> getById() {
    // TODO: implement getById
    throw UnimplementedError();
  }
}
