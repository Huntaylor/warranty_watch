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

@CopyWith()
class CurrentWarrantiesInitialState extends CurrentWarrantiesState {
  CurrentWarrantiesInitialState({required super.warrantyInfoList, required super.expiringList, required super.removeBool});
}
