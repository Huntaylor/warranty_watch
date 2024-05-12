// ignore_for_file: library_private_types_in_public_api

part of 'auth_cubit.dart';

enum LoginType { email, google, apple, initial }

abstract class AuthState extends Equatable {
  const AuthState();

  bool get isAuthenticated => this is _Authenticated;
  bool get isNotAuthenticated => this is _NotAuthenticated;
  bool get isError => this is _Error;
  bool get isLoading => this is _Loading;
  bool get isEmailSuccess => this is _EmailSuccess;

  _Authenticated get asAuthenticated => this as _Authenticated;
  _Initial get asInitial => this as _Initial;
  _Error get asError => this as _Error;
  _Loading get asLoading => this as _Loading;
  _EmailSuccess get asEmailSuccess => this as _EmailSuccess;

  @override
  List<Object?> get props => [];
}

class _Loading extends AuthState {
  const _Loading({this.loginType});
  final LoginType? loginType;
}

@autoequal
class _Authenticated extends AuthState {
  const _Authenticated(this.user);

  final WarrantyUser user;

  @override
  List<Object?> get props => _$props;
}

class _NotAuthenticated extends AuthState {
  const _NotAuthenticated();
}

class _Initial extends AuthState {
  const _Initial();
}

class _EmailSuccess extends AuthState {
  const _EmailSuccess();
}

@autoequal
class _Error extends AuthState {
  const _Error(this.message);

  final String message;

  @override
  List<Object?> get props => _$props;
}
