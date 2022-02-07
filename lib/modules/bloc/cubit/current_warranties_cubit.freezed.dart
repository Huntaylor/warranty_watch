// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'current_warranties_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CurrentWarrantiesStateTearOff {
  const _$CurrentWarrantiesStateTearOff();

  _Initial initial(
      {List<WarrantyInfo> warrantyInfoList = const [],
      bool removeBool = false}) {
    return _Initial(
      warrantyInfoList: warrantyInfoList,
      removeBool: removeBool,
    );
  }
}

/// @nodoc
const $CurrentWarrantiesState = _$CurrentWarrantiesStateTearOff();

/// @nodoc
mixin _$CurrentWarrantiesState {
  List<WarrantyInfo> get warrantyInfoList => throw _privateConstructorUsedError;
  bool get removeBool => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<WarrantyInfo> warrantyInfoList, bool removeBool)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<WarrantyInfo> warrantyInfoList, bool removeBool)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WarrantyInfo> warrantyInfoList, bool removeBool)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentWarrantiesStateCopyWith<CurrentWarrantiesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWarrantiesStateCopyWith<$Res> {
  factory $CurrentWarrantiesStateCopyWith(CurrentWarrantiesState value,
          $Res Function(CurrentWarrantiesState) then) =
      _$CurrentWarrantiesStateCopyWithImpl<$Res>;
  $Res call({List<WarrantyInfo> warrantyInfoList, bool removeBool});
}

/// @nodoc
class _$CurrentWarrantiesStateCopyWithImpl<$Res>
    implements $CurrentWarrantiesStateCopyWith<$Res> {
  _$CurrentWarrantiesStateCopyWithImpl(this._value, this._then);

  final CurrentWarrantiesState _value;
  // ignore: unused_field
  final $Res Function(CurrentWarrantiesState) _then;

  @override
  $Res call({
    Object? warrantyInfoList = freezed,
    Object? removeBool = freezed,
  }) {
    return _then(_value.copyWith(
      warrantyInfoList: warrantyInfoList == freezed
          ? _value.warrantyInfoList
          : warrantyInfoList // ignore: cast_nullable_to_non_nullable
              as List<WarrantyInfo>,
      removeBool: removeBool == freezed
          ? _value.removeBool
          : removeBool // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $CurrentWarrantiesStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({List<WarrantyInfo> warrantyInfoList, bool removeBool});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$CurrentWarrantiesStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? warrantyInfoList = freezed,
    Object? removeBool = freezed,
  }) {
    return _then(_Initial(
      warrantyInfoList: warrantyInfoList == freezed
          ? _value.warrantyInfoList
          : warrantyInfoList // ignore: cast_nullable_to_non_nullable
              as List<WarrantyInfo>,
      removeBool: removeBool == freezed
          ? _value.removeBool
          : removeBool // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial({this.warrantyInfoList = const [], this.removeBool = false})
      : super._();

  @JsonKey()
  @override
  final List<WarrantyInfo> warrantyInfoList;
  @JsonKey()
  @override
  final bool removeBool;

  @override
  String toString() {
    return 'CurrentWarrantiesState.initial(warrantyInfoList: $warrantyInfoList, removeBool: $removeBool)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.warrantyInfoList, warrantyInfoList) &&
            const DeepCollectionEquality()
                .equals(other.removeBool, removeBool));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(warrantyInfoList),
      const DeepCollectionEquality().hash(removeBool));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<WarrantyInfo> warrantyInfoList, bool removeBool)
        initial,
  }) {
    return initial(warrantyInfoList, removeBool);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<WarrantyInfo> warrantyInfoList, bool removeBool)?
        initial,
  }) {
    return initial?.call(warrantyInfoList, removeBool);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WarrantyInfo> warrantyInfoList, bool removeBool)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(warrantyInfoList, removeBool);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends CurrentWarrantiesState {
  const factory _Initial(
      {List<WarrantyInfo> warrantyInfoList, bool removeBool}) = _$_Initial;
  const _Initial._() : super._();

  @override
  List<WarrantyInfo> get warrantyInfoList;
  @override
  bool get removeBool;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
