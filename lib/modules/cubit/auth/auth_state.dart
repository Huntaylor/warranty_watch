part of 'auth_cubit.dart';

enum LoginType { email, google, apple, initial }

abstract class AuthState extends Equatable {
  const AuthState();

  bool get isAuthenticated => this is _Authenticated;
  bool get isNotAuthenticated => this is _NotAuthenticated;
  bool get isError => this is _Error;
  bool get isLoading => this is _Loading;

  _Authenticated get asAuthenticated => this as _Authenticated;
  _Initial get asInitial => this as _Initial;
  _Error get asError => this as _Error;
  _Loading get asLoading => this as _Loading;

  @override
  List<Object?> get props => [];
}

class _Loading extends AuthState {
  final LoginType? loginType;
  const _Loading({this.loginType});
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

@autoequal
class _Error extends AuthState {
  const _Error(this.message);

  final String message;

  @override
  List<Object?> get props => _$props;
}
