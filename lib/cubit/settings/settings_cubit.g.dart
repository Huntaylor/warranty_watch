// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$SetSettingsAutoequal on _SetSettings {
  List<Object?> get _$props => [
        isNotificationAllowed,
        isNotificationEnabled,
        isSomething,
      ];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_SetSettingsCWProxy {
  _SetSettings isNotificationAllowed(bool isNotificationAllowed);

  _SetSettings isSomething(bool isSomething);

  _SetSettings isNotificationEnabled(bool isNotificationEnabled);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_SetSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _SetSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  _SetSettings call({
    bool? isNotificationAllowed,
    bool? isSomething,
    bool? isNotificationEnabled,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_SetSettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_SetSettings.copyWith.fieldName(...)`
class _$_SetSettingsCWProxyImpl implements _$_SetSettingsCWProxy {
  const _$_SetSettingsCWProxyImpl(this._value);

  final _SetSettings _value;

  @override
  _SetSettings isNotificationAllowed(bool isNotificationAllowed) =>
      this(isNotificationAllowed: isNotificationAllowed);

  @override
  _SetSettings isSomething(bool isSomething) => this(isSomething: isSomething);

  @override
  _SetSettings isNotificationEnabled(bool isNotificationEnabled) =>
      this(isNotificationEnabled: isNotificationEnabled);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_SetSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _SetSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  _SetSettings call({
    Object? isNotificationAllowed = const $CopyWithPlaceholder(),
    Object? isSomething = const $CopyWithPlaceholder(),
    Object? isNotificationEnabled = const $CopyWithPlaceholder(),
  }) {
    return _SetSettings(
      isNotificationAllowed:
          isNotificationAllowed == const $CopyWithPlaceholder() ||
                  isNotificationAllowed == null
              ? _value.isNotificationAllowed
              // ignore: cast_nullable_to_non_nullable
              : isNotificationAllowed as bool,
      isSomething:
          isSomething == const $CopyWithPlaceholder() || isSomething == null
              ? _value.isSomething
              // ignore: cast_nullable_to_non_nullable
              : isSomething as bool,
      isNotificationEnabled:
          isNotificationEnabled == const $CopyWithPlaceholder() ||
                  isNotificationEnabled == null
              ? _value.isNotificationEnabled
              // ignore: cast_nullable_to_non_nullable
              : isNotificationEnabled as bool,
    );
  }
}

extension _$_SetSettingsCopyWith on _SetSettings {
  /// Returns a callable class that can be used as follows: `instanceOf_SetSettings.copyWith(...)` or like so:`instanceOf_SetSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_SetSettingsCWProxy get copyWith => _$_SetSettingsCWProxyImpl(this);
}
