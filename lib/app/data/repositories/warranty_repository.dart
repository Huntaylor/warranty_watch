import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/interfaces/iwarranties_source.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

class DataRepository implements IWarrantiesSource {
  final firebase = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final firebaseauth.FirebaseAuth _auth = firebaseauth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<List<WarrantyInfo>> getAll() async {
    final currentUser = _auth.currentUser!.uid;
    late final list = <WarrantyInfo>[];

    final newList =
        await firebase.collection('users/$currentUser/warranties').get();

    for (var i = 0; i < newList.docs.length; i++) {
      list.add(
        WarrantyInfo.fromJson(
          newList.docs[i].data(),
        ),
      );
    }
    return list;
  }

  Stream<List<WarrantyInfo>?> get warrantiesDataStream {
    final currentUser = _auth.currentUser!.uid;

    final warranties =
        firebase.collection('users/$currentUser/warranties').snapshots().map(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs
              .map(
                (e) => WarrantyInfo.fromJson(
                  e.data(),
                ),
              )
              .toList();
        }
      },
    );

    return warranties;
  }

  @override
  Future<void> editWarranty(WarrantyInfo warrantyInfo) async {
    final currentUser = _auth.currentUser!.uid;
    final warrantyFilePath = 'users/$currentUser/warrantyImages';
    final String downloadImageUrl;
    final String downloadReceiptUrl;

    final referenceProduct = storage.ref('$warrantyFilePath/products').child(
          '${warrantyInfo.name}',
        );
    final referenceReceipts = storage.ref('$warrantyFilePath/receipts').child(
          '${warrantyInfo.name}',
        );

    if (warrantyInfo.image != null) {
      final imageTask = referenceProduct.putFile(
        File(
          warrantyInfo.image!,
        ),
      );

      final snapshot = await imageTask;
      downloadImageUrl = await snapshot.ref.getDownloadURL();
    } else {
      downloadImageUrl = '';
    }
    if (warrantyInfo.receiptImage != null) {
      final receiptTask = referenceReceipts.putFile(
        File(
          warrantyInfo.receiptImage!,
        ),
      );

      final snapshot = await receiptTask;
      downloadReceiptUrl = await snapshot.ref.getDownloadURL();
    } else {
      downloadReceiptUrl = '';
    }
    await users.doc('$currentUser/warranties/${warrantyInfo.id}').update(
          warrantyInfo
              .copyWith(
                imageUrl: downloadImageUrl,
                receiptImageUrl: downloadReceiptUrl,
              )
              .toJson(),
        );
  }

  @override
  Future<void> submitWarranty(WarrantyInfo newWarrantyInfo) async {
    final warrantyInfo = newWarrantyInfo.copyWith(createdOn: DateTime.now());
    final String downloadImageUrl;
    final String downloadReceiptUrl;
    final warrantyUuid = const Uuid().v1();
    final currentUser = _auth.currentUser!.uid;
    final warrantyFilePath = 'users/$currentUser';
    try {
      final referenceProduct = storage
          .ref('$warrantyFilePath/products')
          .child('${warrantyInfo.name}');
      final referenceReceipts = storage
          .ref('$warrantyFilePath/receipts')
          .child('${warrantyInfo.name}');

      if (warrantyInfo.image != null) {
        final imageTask = referenceProduct.putFile(File(warrantyInfo.image!));

        final snapshot = await imageTask;
        downloadImageUrl = await snapshot.ref.getDownloadURL();
      } else {
        downloadImageUrl = '';
      }
      if (warrantyInfo.receiptImage != null) {
        final receiptTask =
            referenceReceipts.putFile(File(warrantyInfo.receiptImage!));

        final snapshot = await receiptTask;
        downloadReceiptUrl = await snapshot.ref.getDownloadURL();
      } else {
        downloadReceiptUrl = '';
      }

      final newWarranty = warrantyInfo.copyWith(
        imageUrl: downloadImageUrl,
        receiptImageUrl: downloadReceiptUrl,
        id: warrantyUuid,
      );

      final getWarranties =
          await firebase.collection('users/$currentUser/warranties').get();

      if (getWarranties.docs.any((element) => element.id == newWarranty.id)) {
        // throw (e) {
        //   log(
        //     'Unable to submit new Warranty, already exists',
        //     error: 'Warranty exists',
        //   );
        // };
      }

      await firebase
          .collection('users/$currentUser/warranties')
          .doc(newWarranty.id)
          .set(newWarranty.toJson());
    } catch (e) {
      log(
        "Submitting the warranty didn't work - $e",
      );
      // throw (_) {
      //   e.toString();
      // };
    }
  }

  @override
  Future<void> deleteWarranty(WarrantyInfo warrantyInfo) {
    // TODO(huntaylor): implement deleteWarranty
    throw UnimplementedError();
  }

  @override
  Future<WarrantyInfo> getById(WarrantyInfo warrantyInfo) async {
// TODO(huntaylor):  refactor to get the warranty
// from the UserData within Firebase
    final currentUser = _auth.currentUser!.uid;
    final currentWarranty =
        await users.doc('$currentUser/warranties/${warrantyInfo.id}').get();
    return WarrantyInfo.fromJson(
      Map.from(
        currentWarranty.data()! as Map,
      ),
    );
  }
}
