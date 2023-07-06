import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warranty_keeper/data/models/user.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

abstract class IWarrantiesSource {
  Future<List<WarrantyInfo>> getWarranties(User user);
}

class WarrantiesSource implements IWarrantiesSource {
  @override
  Future<List<WarrantyInfo>> getWarranties(User user) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc('${user.uid}').get();
    final list = snapshot.get('warranties');
    return list;
  }
}
