part of 'auth_cubit.dart';

@freezed
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Authenticated && other.user == user;
  // }

  // @override
  // int get hashCode => user.hashCode;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class NotAuthenticated extends AuthState {
  const NotAuthenticated();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is AuthError && other.message == message;
  // }

  // @override
  // int get hashCode => message.hashCode;

  @override
  List<Object?> get props => [message];
}

class PasswordRequestSubmitted extends AuthState {
  const PasswordRequestSubmitted();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FirstRun extends AuthState {
  const FirstRun();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PersonalDataUpdated extends AuthState {
  const PersonalDataUpdated();

  @override
  List<Object?> get props => throw UnimplementedError();
}
