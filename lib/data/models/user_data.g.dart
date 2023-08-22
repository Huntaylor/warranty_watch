// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$UserDataAutoequal on UserData {
  @Deprecated(r'Use _$props instead')
  List<Object?> get _autoequalProps => _$props;
  List<Object?> get _$props =>
      [email, firstName, lastName, tokens, agreedToServices];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserDataCWProxy {
  UserData firstName(String firstName);

  UserData lastName(String lastName);

  UserData email(String email);

  UserData agreedToServices(bool agreedToServices);

  UserData tokens(Set<String> tokens);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserData(...).copyWith(id: 12, name: "My name")
  /// ````
  UserData call({
    String? firstName,
    String? lastName,
    String? email,
    bool? agreedToServices,
    Set<String>? tokens,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserData.copyWith.fieldName(...)`
class _$UserDataCWProxyImpl implements _$UserDataCWProxy {
  const _$UserDataCWProxyImpl(this._value);

  final UserData _value;

  @override
  UserData firstName(String firstName) => this(firstName: firstName);

  @override
  UserData lastName(String lastName) => this(lastName: lastName);

  @override
  UserData email(String email) => this(email: email);

  @override
  UserData agreedToServices(bool agreedToServices) =>
      this(agreedToServices: agreedToServices);

  @override
  UserData tokens(Set<String> tokens) => this(tokens: tokens);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserData(...).copyWith(id: 12, name: "My name")
  /// ````
  UserData call({
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? agreedToServices = const $CopyWithPlaceholder(),
    Object? tokens = const $CopyWithPlaceholder(),
  }) {
    return UserData(
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      agreedToServices: agreedToServices == const $CopyWithPlaceholder() ||
              agreedToServices == null
          ? _value.agreedToServices
          // ignore: cast_nullable_to_non_nullable
          : agreedToServices as bool,
      tokens: tokens == const $CopyWithPlaceholder() || tokens == null
          ? _value.tokens
          // ignore: cast_nullable_to_non_nullable
          : tokens as Set<String>,
    );
  }
}

extension $UserDataCopyWith on UserData {
  /// Returns a callable class that can be used as follows: `instanceOfUserData.copyWith(...)` or like so:`instanceOfUserData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserDataCWProxy get copyWith => _$UserDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map json) => UserData(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      agreedToServices: json['agreedToServices'] as bool,
      tokens: (json['tokens'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'tokens': instance.tokens.toList(),
      'agreedToServices': instance.agreedToServices,
    };
