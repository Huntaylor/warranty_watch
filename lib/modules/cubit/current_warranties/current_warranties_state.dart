part of 'current_warranties_cubit.dart';

@CopyWith()
class CurrentWarrantiesState {
  const CurrentWarrantiesState({
    required this.warrantyInfoList,
    required this.expiringList,
    required this.removeBool,
  });
  final List<WarrantyInfo> warrantyInfoList;
  final List<WarrantyInfo> expiringList;
  final bool removeBool;
}
