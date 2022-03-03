part of 'current_warranties_cubit.dart';

@freezed
class CurrentWarrantiesState with _$CurrentWarrantiesState {
  const factory CurrentWarrantiesState.initial({
    @Default([]) List<WarrantyInfo> warrantyInfoList,
    @Default([]) List<WarrantyInfo> expiringList,
    @Default(false) bool removeBool,
  }) = _Initial;

  const CurrentWarrantiesState._();
}
