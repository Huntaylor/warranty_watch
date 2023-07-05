// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_warranties_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$_ReadyAutoequal on _Ready {
  @Deprecated(r'Use _$props instead')
  List<Object?> get _autoequalProps => _$props;
  List<Object?> get _$props => [warrantyInfo, expiring, remove];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_ReadyCWProxy {
  _Ready warrantyInfo(List<WarrantyInfo> warrantyInfo);

  _Ready expiring(List<WarrantyInfo> expiring);

  _Ready remove(bool remove);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    List<WarrantyInfo>? warrantyInfo,
    List<WarrantyInfo>? expiring,
    bool? remove,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_Ready.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_Ready.copyWith.fieldName(...)`
class _$_ReadyCWProxyImpl implements _$_ReadyCWProxy {
  const _$_ReadyCWProxyImpl(this._value);

  final _Ready _value;

  @override
  _Ready warrantyInfo(List<WarrantyInfo> warrantyInfo) =>
      this(warrantyInfo: warrantyInfo);

  @override
  _Ready expiring(List<WarrantyInfo> expiring) => this(expiring: expiring);

  @override
  _Ready remove(bool remove) => this(remove: remove);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    Object? warrantyInfo = const $CopyWithPlaceholder(),
    Object? expiring = const $CopyWithPlaceholder(),
    Object? remove = const $CopyWithPlaceholder(),
  }) {
    return _Ready(
      warrantyInfo:
          warrantyInfo == const $CopyWithPlaceholder() || warrantyInfo == null
              ? _value.warrantyInfo
              // ignore: cast_nullable_to_non_nullable
              : warrantyInfo as List<WarrantyInfo>,
      expiring: expiring == const $CopyWithPlaceholder() || expiring == null
          ? _value.expiring
          // ignore: cast_nullable_to_non_nullable
          : expiring as List<WarrantyInfo>,
      remove: remove == const $CopyWithPlaceholder() || remove == null
          ? _value.remove
          // ignore: cast_nullable_to_non_nullable
          : remove as bool,
    );
  }
}

extension _$_ReadyCopyWith on _Ready {
  /// Returns a callable class that can be used as follows: `instanceOf_Ready.copyWith(...)` or like so:`instanceOf_Ready.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ReadyCWProxy get copyWith => _$_ReadyCWProxyImpl(this);
}
