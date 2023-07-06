import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? uid;
  User({this.uid});

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return User(
      uid: data?['users'],
    );
  }
}
