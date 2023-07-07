part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  _Initial get asInitial => this as _Initial;
  _SignUpProcess get asSignUp => this as _SignUpProcess;

  @override
  List<Object?> get props => [];
}

class _Initial extends SignUpState {
  const _Initial();
}

@CopyWith()
@autoequal
class _SignUpProcess extends SignUpState {
  final bool isObscured;
  final bool hasSixCharacters;
  final bool hasSpecialCharacter;
  final bool hasLowerUpperCase;
  final bool hasNumber;
  final bool isMatching;
  final bool isConfirmObscured;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? firstName;
  final String? lastName;
  final String? age;
  const _SignUpProcess({
    required this.isObscured,
    required this.hasSixCharacters,
    required this.hasSpecialCharacter,
    required this.hasLowerUpperCase,
    required this.hasNumber,
    required this.isMatching,
    required this.isConfirmObscured,
    this.email,
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
    this.age,
  }) : super();

  @override
  List<Object?> get props => _$props;
}
