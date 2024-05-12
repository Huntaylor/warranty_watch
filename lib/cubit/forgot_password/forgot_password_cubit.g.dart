// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$InitialAutoequal on _Initial {
  List<Object?> get _$props => [
        email,
        isEnabled,
      ];
}

extension _$ErrorAutoequal on _Error {
  List<Object?> get _$props => [error];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_InitialCWProxy {
  _Initial isEnabled(bool isEnabled);

  _Initial email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Initial(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Initial(...).copyWith(id: 12, name: "My name")
  /// ````
  _Initial call({
    bool? isEnabled,
    String? email,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_Initial.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_Initial.copyWith.fieldName(...)`
class _$_InitialCWProxyImpl implements _$_InitialCWProxy {
  const _$_InitialCWProxyImpl(this._value);

  final _Initial _value;

  @override
  _Initial isEnabled(bool isEnabled) => this(isEnabled: isEnabled);

  @override
  _Initial email(String email) => this(email: email);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Initial(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Initial(...).copyWith(id: 12, name: "My name")
  /// ````
  _Initial call({
    Object? isEnabled = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return _Initial(
      isEnabled: isEnabled == const $CopyWithPlaceholder() || isEnabled == null
          ? _value.isEnabled
          // ignore: cast_nullable_to_non_nullable
          : isEnabled as bool,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension _$_InitialCopyWith on _Initial {
  /// Returns a callable class that can be used as follows: `instanceOf_Initial.copyWith(...)` or like so:`instanceOf_Initial.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_InitialCWProxy get copyWith => _$_InitialCWProxyImpl(this);
}

abstract class _$_ErrorCWProxy {
  _Error error(String error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Error(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Error(...).copyWith(id: 12, name: "My name")
  /// ````
  _Error call({
    String? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_Error.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_Error.copyWith.fieldName(...)`
class _$_ErrorCWProxyImpl implements _$_ErrorCWProxy {
  const _$_ErrorCWProxyImpl(this._value);

  final _Error _value;

  @override
  _Error error(String error) => this(error: error);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Error(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Error(...).copyWith(id: 12, name: "My name")
  /// ````
  _Error call({
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return _Error(
      error: error == const $CopyWithPlaceholder() || error == null
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String,
    );
  }
}

extension _$_ErrorCopyWith on _Error {
  /// Returns a callable class that can be used as follows: `instanceOf_Error.copyWith(...)` or like so:`instanceOf_Error.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ErrorCWProxy get copyWith => _$_ErrorCWProxyImpl(this);
}
