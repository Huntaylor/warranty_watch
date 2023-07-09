part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  bool get isLoggingIn => this is _LoggingIn;
  bool get isInitial => this is _Initial;

  _Initial get asInitial => this as _Initial;
  _LoggingIn get asLoggingIn => this as _LoggingIn;

  @override
  List<Object?> get props => [];
}

class _Initial extends LoginState {
  const _Initial();
}

@CopyWith()
@autoequal
class _LoggingIn extends LoginState {
  const _LoggingIn({required this.email, required this.password, required this.isObscured});

  final String email;
  final String password;
  final bool isObscured;

  @override
  List<Object?> get props => _$props;
}
