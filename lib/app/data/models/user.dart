import 'package:cloud_firestore/cloud_firestore.dart';

class WarrantyUser {
  WarrantyUser({this.uid});

  factory WarrantyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return WarrantyUser(
      uid: data!['users'].toString(),
    );
  }
  final String? uid;
}
