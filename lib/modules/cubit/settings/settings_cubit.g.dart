// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$SetSettingsAutoequal on _SetSettings {
  List<Object?> get _$props => [
        isNotifications,
        isSomething,
      ];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_SetSettingsCWProxy {
  _SetSettings isNotifications(bool isNotifications);

  _SetSettings isSomething(bool isSomething);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_SetSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _SetSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  _SetSettings call({
    bool? isNotifications,
    bool? isSomething,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_SetSettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_SetSettings.copyWith.fieldName(...)`
class _$_SetSettingsCWProxyImpl implements _$_SetSettingsCWProxy {
  const _$_SetSettingsCWProxyImpl(this._value);

  final _SetSettings _value;

  @override
  _SetSettings isNotifications(bool isNotifications) =>
      this(isNotifications: isNotifications);

  @override
  _SetSettings isSomething(bool isSomething) => this(isSomething: isSomething);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_SetSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _SetSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  _SetSettings call({
    Object? isNotifications = const $CopyWithPlaceholder(),
    Object? isSomething = const $CopyWithPlaceholder(),
  }) {
    return _SetSettings(
      isNotifications: isNotifications == const $CopyWithPlaceholder() ||
              isNotifications == null
          ? _value.isNotifications
          // ignore: cast_nullable_to_non_nullable
          : isNotifications as bool,
      isSomething:
          isSomething == const $CopyWithPlaceholder() || isSomething == null
              ? _value.isSomething
              // ignore: cast_nullable_to_non_nullable
              : isSomething as bool,
    );
  }
}

extension _$_SetSettingsCopyWith on _SetSettings {
  /// Returns a callable class that can be used as follows: `instanceOf_SetSettings.copyWith(...)` or like so:`instanceOf_SetSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_SetSettingsCWProxy get copyWith => _$_SetSettingsCWProxyImpl(this);
}
