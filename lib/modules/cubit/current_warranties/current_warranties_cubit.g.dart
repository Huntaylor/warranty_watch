// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_warranties_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CurrentWarrantiesStateCWProxy {
  CurrentWarrantiesState warrantyInfoList(List<WarrantyInfo> warrantyInfoList);

  CurrentWarrantiesState expiringList(List<WarrantyInfo> expiringList);

  CurrentWarrantiesState removeBool(bool removeBool);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CurrentWarrantiesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CurrentWarrantiesState(...).copyWith(id: 12, name: "My name")
  /// ````
  CurrentWarrantiesState call({
    List<WarrantyInfo>? warrantyInfoList,
    List<WarrantyInfo>? expiringList,
    bool? removeBool,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCurrentWarrantiesState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCurrentWarrantiesState.copyWith.fieldName(...)`
class _$CurrentWarrantiesStateCWProxyImpl
    implements _$CurrentWarrantiesStateCWProxy {
  const _$CurrentWarrantiesStateCWProxyImpl(this._value);

  final CurrentWarrantiesState _value;

  @override
  CurrentWarrantiesState warrantyInfoList(
          List<WarrantyInfo> warrantyInfoList) =>
      this(warrantyInfoList: warrantyInfoList);

  @override
  CurrentWarrantiesState expiringList(List<WarrantyInfo> expiringList) =>
      this(expiringList: expiringList);

  @override
  CurrentWarrantiesState removeBool(bool removeBool) =>
      this(removeBool: removeBool);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CurrentWarrantiesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CurrentWarrantiesState(...).copyWith(id: 12, name: "My name")
  /// ````
  CurrentWarrantiesState call({
    Object? warrantyInfoList = const $CopyWithPlaceholder(),
    Object? expiringList = const $CopyWithPlaceholder(),
    Object? removeBool = const $CopyWithPlaceholder(),
  }) {
    return CurrentWarrantiesState(
      warrantyInfoList: warrantyInfoList == const $CopyWithPlaceholder() ||
              warrantyInfoList == null
          ? _value.warrantyInfoList
          // ignore: cast_nullable_to_non_nullable
          : warrantyInfoList as List<WarrantyInfo>,
      expiringList:
          expiringList == const $CopyWithPlaceholder() || expiringList == null
              ? _value.expiringList
              // ignore: cast_nullable_to_non_nullable
              : expiringList as List<WarrantyInfo>,
      removeBool:
          removeBool == const $CopyWithPlaceholder() || removeBool == null
              ? _value.removeBool
              // ignore: cast_nullable_to_non_nullable
              : removeBool as bool,
    );
  }
}

extension $CurrentWarrantiesStateCopyWith on CurrentWarrantiesState {
  /// Returns a callable class that can be used as follows: `instanceOfCurrentWarrantiesState.copyWith(...)` or like so:`instanceOfCurrentWarrantiesState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CurrentWarrantiesStateCWProxy get copyWith =>
      _$CurrentWarrantiesStateCWProxyImpl(this);
}
