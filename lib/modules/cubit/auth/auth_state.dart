part of 'auth_cubit.dart';

@autoequal
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => _$props;
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object?> get props => _$props;
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => _$props;
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => _$props;
}

class NotAuthenticated extends AuthState {
  const NotAuthenticated();

  @override
  List<Object?> get props => _$props;
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => _$props;
}

class PasswordRequestSubmitted extends AuthState {
  const PasswordRequestSubmitted();

  @override
  List<Object?> get props => _$props;
}

class FirstRun extends AuthState {
  const FirstRun();

  @override
  List<Object?> get props => _$props;
}

class PersonalDataUpdated extends AuthState {
  const PersonalDataUpdated();

  @override
  List<Object?> get props => _$props;
}
