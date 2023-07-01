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
  final List<WarrantyInfo> warrantyInfoList;
  final List<WarrantyInfo> expiringList;
  final bool removeBool;

  CurrentWarrantiesInitialState(
    this.expiringList,
    this.removeBool,
    this.warrantyInfoList,
  ) : super(warrantyInfoList: [], expiringList: [], removeBool: false);
}
