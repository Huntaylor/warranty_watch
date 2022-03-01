// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'barcode_scanner_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BarcodeScannerStateTearOff {
  const _$BarcodeScannerStateTearOff();

  _Initial initial({String barcodeText = ''}) {
    return _Initial(
      barcodeText: barcodeText,
    );
  }
}

/// @nodoc
const $BarcodeScannerState = _$BarcodeScannerStateTearOff();

/// @nodoc
mixin _$BarcodeScannerState {
  String get barcodeText => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String barcodeText) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String barcodeText)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String barcodeText)? initial,
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
  $BarcodeScannerStateCopyWith<BarcodeScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeScannerStateCopyWith<$Res> {
  factory $BarcodeScannerStateCopyWith(
          BarcodeScannerState value, $Res Function(BarcodeScannerState) then) =
      _$BarcodeScannerStateCopyWithImpl<$Res>;
  $Res call({String barcodeText});
}

/// @nodoc
class _$BarcodeScannerStateCopyWithImpl<$Res>
    implements $BarcodeScannerStateCopyWith<$Res> {
  _$BarcodeScannerStateCopyWithImpl(this._value, this._then);

  final BarcodeScannerState _value;
  // ignore: unused_field
  final $Res Function(BarcodeScannerState) _then;

  @override
  $Res call({
    Object? barcodeText = freezed,
  }) {
    return _then(_value.copyWith(
      barcodeText: barcodeText == freezed
          ? _value.barcodeText
          : barcodeText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $BarcodeScannerStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({String barcodeText});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$BarcodeScannerStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? barcodeText = freezed,
  }) {
    return _then(_Initial(
      barcodeText: barcodeText == freezed
          ? _value.barcodeText
          : barcodeText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.barcodeText = ''});

  @JsonKey()
  @override
  final String barcodeText;

  @override
  String toString() {
    return 'BarcodeScannerState.initial(barcodeText: $barcodeText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.barcodeText, barcodeText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(barcodeText));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String barcodeText) initial,
  }) {
    return initial(barcodeText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String barcodeText)? initial,
  }) {
    return initial?.call(barcodeText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String barcodeText)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(barcodeText);
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

abstract class _Initial implements BarcodeScannerState {
  const factory _Initial({String barcodeText}) = _$_Initial;

  @override
  String get barcodeText;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
