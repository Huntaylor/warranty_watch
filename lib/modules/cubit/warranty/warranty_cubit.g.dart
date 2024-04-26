// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranty_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$ReadyAutoequal on _Ready {
  List<Object?> get _$props => [
        warrantyInfo,
        selectedWarrantyDateChip,
        selectedReminderDateChip,
        hasError,
      ];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_ReadyCWProxy {
  _Ready warrantyInfo(WarrantyInfo warrantyInfo);

  _Ready selectedReminderDateChip(int? selectedReminderDateChip);

  _Ready selectedWarrantyDateChip(int? selectedWarrantyDateChip);

  _Ready hasError(bool? hasError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    WarrantyInfo? warrantyInfo,
    int? selectedReminderDateChip,
    int? selectedWarrantyDateChip,
    bool? hasError,
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
  _Ready selectedReminderDateChip(int? selectedReminderDateChip) =>
      this(selectedReminderDateChip: selectedReminderDateChip);

  @override
  _Ready selectedWarrantyDateChip(int? selectedWarrantyDateChip) =>
      this(selectedWarrantyDateChip: selectedWarrantyDateChip);

  @override
  _Ready hasError(bool? hasError) => this(hasError: hasError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    Object? warrantyInfo = const $CopyWithPlaceholder(),
    Object? selectedReminderDateChip = const $CopyWithPlaceholder(),
    Object? selectedWarrantyDateChip = const $CopyWithPlaceholder(),
    Object? hasError = const $CopyWithPlaceholder(),
  }) {
    return _Ready(
      warrantyInfo:
          warrantyInfo == const $CopyWithPlaceholder() || warrantyInfo == null
              ? _value.warrantyInfo
              // ignore: cast_nullable_to_non_nullable
              : warrantyInfo as WarrantyInfo,
      selectedReminderDateChip:
          selectedReminderDateChip == const $CopyWithPlaceholder()
              ? _value.selectedReminderDateChip
              // ignore: cast_nullable_to_non_nullable
              : selectedReminderDateChip as int?,
      selectedWarrantyDateChip:
          selectedWarrantyDateChip == const $CopyWithPlaceholder()
              ? _value.selectedWarrantyDateChip
              // ignore: cast_nullable_to_non_nullable
              : selectedWarrantyDateChip as int?,
      hasError: hasError == const $CopyWithPlaceholder()
          ? _value.hasError
          // ignore: cast_nullable_to_non_nullable
          : hasError as bool?,
    );
  }
}

extension _$_ReadyCopyWith on _Ready {
  /// Returns a callable class that can be used as follows: `instanceOf_Ready.copyWith(...)` or like so:`instanceOf_Ready.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ReadyCWProxy get copyWith => _$_ReadyCWProxyImpl(this);
}
