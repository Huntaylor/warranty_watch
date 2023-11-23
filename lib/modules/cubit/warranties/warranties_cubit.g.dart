// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warranties_cubit.dart';

// **************************************************************************
// AutoequalGenerator
// **************************************************************************

extension _$_ReadyAutoequal on _Ready {
  @Deprecated(r'Use _$props instead')
  List<Object?> get _autoequalProps => _$props;
  List<Object?> get _$props => [warranties, isProductImage];
}

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$_ReadyCWProxy {
  _Ready warranties(List<WarrantyInfo> warranties);

  _Ready isProductImage(bool isProductImage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    List<WarrantyInfo>? warranties,
    bool? isProductImage,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOf_Ready.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOf_Ready.copyWith.fieldName(...)`
class _$_ReadyCWProxyImpl implements _$_ReadyCWProxy {
  const _$_ReadyCWProxyImpl(this._value);

  final _Ready _value;

  @override
  _Ready warranties(List<WarrantyInfo> warranties) =>
      this(warranties: warranties);

  @override
  _Ready isProductImage(bool isProductImage) =>
      this(isProductImage: isProductImage);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `_Ready(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// _Ready(...).copyWith(id: 12, name: "My name")
  /// ````
  _Ready call({
    Object? warranties = const $CopyWithPlaceholder(),
    Object? isProductImage = const $CopyWithPlaceholder(),
  }) {
    return _Ready(
      warranties:
          warranties == const $CopyWithPlaceholder() || warranties == null
              ? _value.warranties
              // ignore: cast_nullable_to_non_nullable
              : warranties as List<WarrantyInfo>,
      isProductImage: isProductImage == const $CopyWithPlaceholder() ||
              isProductImage == null
          ? _value.isProductImage
          // ignore: cast_nullable_to_non_nullable
          : isProductImage as bool,
    );
  }
}

extension _$_ReadyCopyWith on _Ready {
  /// Returns a callable class that can be used as follows: `instanceOf_Ready.copyWith(...)` or like so:`instanceOf_Ready.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$_ReadyCWProxy get copyWith => _$_ReadyCWProxyImpl(this);
}
