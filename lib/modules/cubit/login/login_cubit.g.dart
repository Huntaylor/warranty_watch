// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$_LoggingInAutoequal on _LoggingIn {
  @Deprecated(r'Use _$props instead')
  List<Object?> get _autoequalProps => _$props;
  List<Object?> get _$props => [email, password, isObscured];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_LoggingInCWProxy {
  _LoggingIn email(String email);

  _LoggingIn password(String password);

  _LoggingIn isObscured(bool isObscured);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_LoggingIn(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _LoggingIn(...).copyWith(id: 12, name: "My name")
  /// ````
  _LoggingIn call({
    String? email,
    String? password,
    bool? isObscured,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_LoggingIn.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_LoggingIn.copyWith.fieldName(...)`
class _$_LoggingInCWProxyImpl implements _$_LoggingInCWProxy {
  const _$_LoggingInCWProxyImpl(this._value);

  final _LoggingIn _value;

  @override
  _LoggingIn email(String email) => this(email: email);

  @override
  _LoggingIn password(String password) => this(password: password);

  @override
  _LoggingIn isObscured(bool isObscured) => this(isObscured: isObscured);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_LoggingIn(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _LoggingIn(...).copyWith(id: 12, name: "My name")
  /// ````
  _LoggingIn call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? isObscured = const $CopyWithPlaceholder(),
  }) {
    return _LoggingIn(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      isObscured:
          isObscured == const $CopyWithPlaceholder() || isObscured == null
              ? _value.isObscured
              // ignore: cast_nullable_to_non_nullable
              : isObscured as bool,
    );
  }
}

extension _$_LoggingInCopyWith on _LoggingIn {
  /// Returns a callable class that can be used as follows: `instanceOf_LoggingIn.copyWith(...)` or like so:`instanceOf_LoggingIn.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_LoggingInCWProxy get copyWith => _$_LoggingInCWProxyImpl(this);
}
