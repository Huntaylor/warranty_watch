import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

abstract class IWarrantiesSource {
  Future<void> submitWarranty(WarrantyInfo warrantyInfo);
  Future<void> editWarranty(WarrantyInfo warrantyInfo);
  Future<void> deleteWarranty(WarrantyInfo warrantyInfo);
  Future<List<WarrantyInfo>> getAll();
  Future<List<WarrantyInfo>> getAllExpiring();
  Future<List<WarrantyInfo>> getAllExpired();
  Future<WarrantyInfo> getById(WarrantyInfo warrantyInfo);
}
