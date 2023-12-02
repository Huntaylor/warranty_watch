// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$_ReadyAutoequal on _Ready {
  @Deprecated(r'Use _$props instead')
  List<Object?> get _autoequalProps => _$props;
  List<Object?> get _$props => [
        warrantyInfo,
        selectedChip,
      ];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_ReadyCWProxy {
  _Ready warrantyInfo(WarrantyInfo warrantyInfo);

  _Ready selectedChip(int? selectedChip);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    WarrantyInfo? warrantyInfo,
    int? selectedChip,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_Ready.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_Ready.copyWith.fieldName(...)`
class _$_ReadyCWProxyImpl implements _$_ReadyCWProxy {
  const _$_ReadyCWProxyImpl(this._value);

  final _Ready _value;

  @override
  _Ready warrantyInfo(WarrantyInfo warrantyInfo) =>
      this(warrantyInfo: warrantyInfo);

  @override
  _Ready selectedChip(int? selectedChip) => this(selectedChip: selectedChip);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    Object? warrantyInfo = const $CopyWithPlaceholder(),
    Object? selectedChip = const $CopyWithPlaceholder(),
  }) {
    return _Ready(
      warrantyInfo:
          warrantyInfo == const $CopyWithPlaceholder() || warrantyInfo == null
              ? _value.warrantyInfo
              // ignore: cast_nullable_to_non_nullable
              : warrantyInfo as WarrantyInfo,
      selectedChip: selectedChip == const $CopyWithPlaceholder()
          ? _value.selectedChip
          // ignore: cast_nullable_to_non_nullable
          : selectedChip as int?,
    );
  }
}

extension _$_ReadyCopyWith on _Ready {
  /// Returns a callable class that can be used as follows: `instanceOf_Ready.copyWith(...)` or like so:`instanceOf_Ready.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ReadyCWProxy get copyWith => _$_ReadyCWProxyImpl(this);
}
