import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warranty_watch/app/data/models/user_data.dart';

class UserCollection {
  UserCollection();

  Future<UserData> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    assert(currentUser?.uid != null, 'Current user uid cannot be null');

    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
    final userData = UserData.fromJson(Map.from(userDocs.data()!));
    return userData;
  }
}
