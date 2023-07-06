// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loading loading({LoadingState loadingState = LoadingState.initial}) {
    return _Loading(
      loadingState: loadingState,
    );
  }

  _Authenticated authenticated({User? user = null}) {
    return _Authenticated(
      user: user,
    );
  }

  _NotAuthenticated notAuthenticated() {
    return const _NotAuthenticated();
  }

  _Error error({String message = ''}) {
    return _Error(
      message: message,
    );
  }

  _PasswordRequestSubmitted passwordRequestSubmitted() {
    return const _PasswordRequestSubmitted();
  }

  _FirstRun firstRun() {
    return const _FirstRun();
  }

  _PersonalDataUpdated personalDataUpdated() {
    return const _PersonalDataUpdated();
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial with DiagnosticableTreeMixin implements _Initial {
  const _$_Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  $Res call({LoadingState loadingState});
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? loadingState = freezed,
  }) {
    return _then(_Loading(
      loadingState: loadingState == freezed
          ? _value.loadingState
          : loadingState // ignore: cast_nullable_to_non_nullable
              as LoadingState,
    ));
  }
}

/// @nodoc

class _$_Loading with DiagnosticableTreeMixin implements _Loading {
  const _$_Loading({this.loadingState = LoadingState.initial});

  @JsonKey()
  @override
  final LoadingState loadingState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading(loadingState: $loadingState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.loading'))
      ..add(DiagnosticsProperty('loadingState', loadingState));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality()
                .equals(other.loadingState, loadingState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(loadingState));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return loading(loadingState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return loading?.call(loadingState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(loadingState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading({LoadingState loadingState}) = _$_Loading;

  LoadingState get loadingState;
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthenticatedCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(
          _Authenticated value, $Res Function(_Authenticated) then) =
      __$AuthenticatedCopyWithImpl<$Res>;
  $Res call({User? user});
}

/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(
      _Authenticated _value, $Res Function(_Authenticated) _then)
      : super(_value, (v) => _then(v as _Authenticated));

  @override
  _Authenticated get _value => super._value as _Authenticated;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_Authenticated(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_Authenticated with DiagnosticableTreeMixin implements _Authenticated {
  const _$_Authenticated({this.user = null});

  @JsonKey()
  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.authenticated'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Authenticated &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated({User? user}) = _$_Authenticated;

  User? get user;
  @JsonKey(ignore: true)
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NotAuthenticatedCopyWith<$Res> {
  factory _$NotAuthenticatedCopyWith(
          _NotAuthenticated value, $Res Function(_NotAuthenticated) then) =
      __$NotAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$NotAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$NotAuthenticatedCopyWith<$Res> {
  __$NotAuthenticatedCopyWithImpl(
      _NotAuthenticated _value, $Res Function(_NotAuthenticated) _then)
      : super(_value, (v) => _then(v as _NotAuthenticated));

  @override
  _NotAuthenticated get _value => super._value as _NotAuthenticated;
}

/// @nodoc

class _$_NotAuthenticated
    with DiagnosticableTreeMixin
    implements _NotAuthenticated {
  const _$_NotAuthenticated();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.notAuthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.notAuthenticated'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NotAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return notAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return notAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (notAuthenticated != null) {
      return notAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return notAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return notAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (notAuthenticated != null) {
      return notAuthenticated(this);
    }
    return orElse();
  }
}

abstract class _NotAuthenticated implements AuthState {
  const factory _NotAuthenticated() = _$_NotAuthenticated;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_Error(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error with DiagnosticableTreeMixin implements _Error {
  const _$_Error({this.message = ''});

  @JsonKey()
  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error({String message}) = _$_Error;

  String get message;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PasswordRequestSubmittedCopyWith<$Res> {
  factory _$PasswordRequestSubmittedCopyWith(_PasswordRequestSubmitted value,
          $Res Function(_PasswordRequestSubmitted) then) =
      __$PasswordRequestSubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PasswordRequestSubmittedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$PasswordRequestSubmittedCopyWith<$Res> {
  __$PasswordRequestSubmittedCopyWithImpl(_PasswordRequestSubmitted _value,
      $Res Function(_PasswordRequestSubmitted) _then)
      : super(_value, (v) => _then(v as _PasswordRequestSubmitted));

  @override
  _PasswordRequestSubmitted get _value =>
      super._value as _PasswordRequestSubmitted;
}

/// @nodoc

class _$_PasswordRequestSubmitted
    with DiagnosticableTreeMixin
    implements _PasswordRequestSubmitted {
  const _$_PasswordRequestSubmitted();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.passwordRequestSubmitted()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.passwordRequestSubmitted'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PasswordRequestSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return passwordRequestSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return passwordRequestSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (passwordRequestSubmitted != null) {
      return passwordRequestSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return passwordRequestSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return passwordRequestSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (passwordRequestSubmitted != null) {
      return passwordRequestSubmitted(this);
    }
    return orElse();
  }
}

abstract class _PasswordRequestSubmitted implements AuthState {
  const factory _PasswordRequestSubmitted() = _$_PasswordRequestSubmitted;
}

/// @nodoc
abstract class _$FirstRunCopyWith<$Res> {
  factory _$FirstRunCopyWith(_FirstRun value, $Res Function(_FirstRun) then) =
      __$FirstRunCopyWithImpl<$Res>;
}

/// @nodoc
class __$FirstRunCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$FirstRunCopyWith<$Res> {
  __$FirstRunCopyWithImpl(_FirstRun _value, $Res Function(_FirstRun) _then)
      : super(_value, (v) => _then(v as _FirstRun));

  @override
  _FirstRun get _value => super._value as _FirstRun;
}

/// @nodoc

class _$_FirstRun with DiagnosticableTreeMixin implements _FirstRun {
  const _$_FirstRun();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.firstRun()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.firstRun'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FirstRun);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return firstRun();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return firstRun?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (firstRun != null) {
      return firstRun();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return firstRun(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return firstRun?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (firstRun != null) {
      return firstRun(this);
    }
    return orElse();
  }
}

abstract class _FirstRun implements AuthState {
  const factory _FirstRun() = _$_FirstRun;
}

/// @nodoc
abstract class _$PersonalDataUpdatedCopyWith<$Res> {
  factory _$PersonalDataUpdatedCopyWith(_PersonalDataUpdated value,
          $Res Function(_PersonalDataUpdated) then) =
      __$PersonalDataUpdatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PersonalDataUpdatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$PersonalDataUpdatedCopyWith<$Res> {
  __$PersonalDataUpdatedCopyWithImpl(
      _PersonalDataUpdated _value, $Res Function(_PersonalDataUpdated) _then)
      : super(_value, (v) => _then(v as _PersonalDataUpdated));

  @override
  _PersonalDataUpdated get _value => super._value as _PersonalDataUpdated;
}

/// @nodoc

class _$_PersonalDataUpdated
    with DiagnosticableTreeMixin
    implements _PersonalDataUpdated {
  const _$_PersonalDataUpdated();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.personalDataUpdated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.personalDataUpdated'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PersonalDataUpdated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(LoadingState loadingState) loading,
    required TResult Function(User? user) authenticated,
    required TResult Function() notAuthenticated,
    required TResult Function(String message) error,
    required TResult Function() passwordRequestSubmitted,
    required TResult Function() firstRun,
    required TResult Function() personalDataUpdated,
  }) {
    return personalDataUpdated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
  }) {
    return personalDataUpdated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(LoadingState loadingState)? loading,
    TResult Function(User? user)? authenticated,
    TResult Function()? notAuthenticated,
    TResult Function(String message)? error,
    TResult Function()? passwordRequestSubmitted,
    TResult Function()? firstRun,
    TResult Function()? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (personalDataUpdated != null) {
      return personalDataUpdated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotAuthenticated value) notAuthenticated,
    required TResult Function(_Error value) error,
    required TResult Function(_PasswordRequestSubmitted value)
        passwordRequestSubmitted,
    required TResult Function(_FirstRun value) firstRun,
    required TResult Function(_PersonalDataUpdated value) personalDataUpdated,
  }) {
    return personalDataUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
  }) {
    return personalDataUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotAuthenticated value)? notAuthenticated,
    TResult Function(_Error value)? error,
    TResult Function(_PasswordRequestSubmitted value)? passwordRequestSubmitted,
    TResult Function(_FirstRun value)? firstRun,
    TResult Function(_PersonalDataUpdated value)? personalDataUpdated,
    required TResult orElse(),
  }) {
    if (personalDataUpdated != null) {
      return personalDataUpdated(this);
    }
    return orElse();
  }
}

abstract class _PersonalDataUpdated implements AuthState {
  const factory _PersonalDataUpdated() = _$_PersonalDataUpdated;
}
