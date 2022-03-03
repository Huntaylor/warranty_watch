part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default([]) List<WarrantyInfo> expiringList,
  }) = _Initial;

  const HomeState._();
}
