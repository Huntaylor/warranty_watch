part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Authenticated && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class NotAuthenticated extends AuthState {
  const NotAuthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class PasswordRequestSubmitted extends AuthState {
  const PasswordRequestSubmitted();
}

class FirstRun extends AuthState {
  const FirstRun();
}

class PersonalDataUpdated extends AuthState {
  const PersonalDataUpdated();
}
