import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

abstract class IWarrantiesSource {
  Future<List<WarrantyInfo>> getWarranties();
}

class WarrantiesSource implements IWarrantiesSource {
  @override
  Future<List<WarrantyInfo>> getWarranties() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get();
    final list = snapshot.get('warranties');
    return list;
  }
}
