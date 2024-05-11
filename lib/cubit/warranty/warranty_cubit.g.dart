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
        firebaseError,
        isLoading,
        canSubmit,
        isNotificationEnabled,
        askedNotification,
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

  _Ready firebaseError(bool? firebaseError);

  _Ready isLoading(bool? isLoading);

  _Ready canSubmit(bool? canSubmit);

  _Ready isNotificationEnabled(bool isNotificationEnabled);

  _Ready askedNotification(bool askedNotification);

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
    bool? firebaseError,
    bool? isLoading,
    bool? canSubmit,
    bool? isNotificationEnabled,
    bool? askedNotification,
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
  _Ready firebaseError(bool? firebaseError) =>
      this(firebaseError: firebaseError);

  @override
  _Ready isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  _Ready canSubmit(bool? canSubmit) => this(canSubmit: canSubmit);

  @override
  _Ready isNotificationEnabled(bool isNotificationEnabled) =>
      this(isNotificationEnabled: isNotificationEnabled);

  @override
  _Ready askedNotification(bool askedNotification) =>
      this(askedNotification: askedNotification);

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
    Object? firebaseError = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? canSubmit = const $CopyWithPlaceholder(),
    Object? isNotificationEnabled = const $CopyWithPlaceholder(),
    Object? askedNotification = const $CopyWithPlaceholder(),
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
      firebaseError: firebaseError == const $CopyWithPlaceholder()
          ? _value.firebaseError
          // ignore: cast_nullable_to_non_nullable
          : firebaseError as bool?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      canSubmit: canSubmit == const $CopyWithPlaceholder()
          ? _value.canSubmit
          // ignore: cast_nullable_to_non_nullable
          : canSubmit as bool?,
      isNotificationEnabled:
          isNotificationEnabled == const $CopyWithPlaceholder() ||
                  isNotificationEnabled == null
              ? _value.isNotificationEnabled
              // ignore: cast_nullable_to_non_nullable
              : isNotificationEnabled as bool,
      askedNotification: askedNotification == const $CopyWithPlaceholder() ||
              askedNotification == null
          ? _value.askedNotification
          // ignore: cast_nullable_to_non_nullable
          : askedNotification as bool,
    );
  }
}

extension _$_ReadyCopyWith on _Ready {
  /// Returns a callable class that can be used as follows: `instanceOf_Ready.copyWith(...)` or like so:`instanceOf_Ready.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ReadyCWProxy get copyWith => _$_ReadyCWProxyImpl(this);
}
