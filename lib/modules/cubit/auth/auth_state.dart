part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  bool get isAuthenticated => this is _Authenticated;
  bool get isNotAuthenticated => this is _NotAuthenticated;
  bool get isError => this is _Error;
  bool get isLoading => this is _Loading;

  _Authenticated get asAuthenticated => this as _Authenticated;
  _Error get asError => this as _Error;

  @override
  List<Object?> get props => [];
}

class _Loading extends AuthState {
  const _Loading();
}

@autoequal
class _Authenticated extends AuthState {
  const _Authenticated(this.user);

  final User user;

  @override
  List<Object?> get props => _$props;
}

class _NotAuthenticated extends AuthState {
  const _NotAuthenticated();
}

@autoequal
class _Error extends AuthState {
  const _Error(this.message);

  final String message;

  @override
  List<Object?> get props => _$props;
}
