import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warranty_keeper/data/models/user_data.dart';
import 'package:warranty_keeper/data/interfaces/iuser_collection_source.dart';

class UserCollection extends IUserCollection {
  UserCollection();

  @override
  Future<UserData> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    assert(currentUser?.uid != null, 'Current user uid cannot be null');

    final userDocs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
    final userData = UserData.fromJson(Map.from(userDocs.data() as Map));
    return userData;
  }
}
