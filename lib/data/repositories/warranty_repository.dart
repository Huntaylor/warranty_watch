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
  Future<List<WarrantyInfo>> getAll();
  Future<WarrantyInfo> getById(WarrantyInfo warrantyInfo);
}

class FirebaseDataRepository implements WarrantyRepository {
  FirebaseStorage storage = FirebaseStorage.instance;
  final firebaseauth.FirebaseAuth _auth = firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> editWarranty(WarrantyInfo warrantyInfo) async {
    final currentUser = _auth.currentUser!.uid;
    final String warrantyFilePath = 'users/$currentUser/warrantyImages';
    final String downloadImageUrl;
    final String downloadReceiptUrl;

    final referenceProduct = storage.ref('$warrantyFilePath/products').child('${warrantyInfo.name}');
    final referenceReceipts = storage.ref('$warrantyFilePath/receipts').child('${warrantyInfo.name}');

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
    await users.doc(currentUser).collection('warranties').doc(warrantyInfo.id).update(
          warrantyInfo
              .copyWith(
                imageUrl: downloadImageUrl,
                receiptImageUrl: downloadReceiptUrl,
              )
              .toMap(),
        );
  }

  @override
  Future<void> submitWarranty(WarrantyInfo warrantyInfo) async {
    final String downloadImageUrl;
    final String downloadReceiptUrl;
    final warrantyUuid = const Uuid().v1();
    final currentUser = _auth.currentUser!.uid;
    final String warrantyFilePath = 'users/$currentUser/warrantyImages';
    try {
      final referenceProduct = storage.ref('$warrantyFilePath/products').child('${warrantyInfo.name}');
      final referenceReceipts = storage.ref('$warrantyFilePath/receipts').child('${warrantyInfo.name}');

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

      await users.doc(currentUser).collection('warranties').doc(warrantyUuid).set(
            warrantyInfo
                .copyWith(
                  imageUrl: downloadImageUrl,
                  receiptImageUrl: downloadReceiptUrl,
                  id: warrantyUuid,
                )
                .toMap(),
          );
    } catch (e) {
      log(
        'Submitting the warranty didn\'t work - ${e.toString()}',
      );
    }
  }

  @override
  Future<List<WarrantyInfo>> getAll() async {
    final List<WarrantyInfo> warranties = [];
    final currentUser = _auth.currentUser!.uid;
    final warrantiesData = await users.doc(currentUser).collection('warranties').get();

    for (var i = 0; i < warrantiesData.docs.length; i++) {
      warranties.add(
        WarrantyInfo.fromMap(
          warrantiesData.docs[i].data(),
        ),
      );
    }

    return warranties;
  }

  @override
  Future<void> deleteWarranty(WarrantyInfo warrantyInfo) {
    // TODO: implement deleteWarranty
    throw UnimplementedError();
  }

  @override
  Future<WarrantyInfo> getById(WarrantyInfo warrantyInfo) async {
    //TODO: NEED TO ADD LISTENER TO REFRESH WHEN A NEW WARRANTY IS ADDED
    final currentUser = _auth.currentUser!.uid;
    final currentWarranty = await users.doc(currentUser).collection('warranties').doc(warrantyInfo.id).get();
    return WarrantyInfo.fromMap(currentWarranty.data()!);
  }
}
