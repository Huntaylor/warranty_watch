part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  bool get isLoading => this is _Loading;
  bool get isError => this is _Error;

  _Loading get asLoading => this as _Loading;
  _Initial get asInitial => this as _Initial;
  _Error get asError => this as _Error;
  _SignUpProcess get asSignUp => this as _SignUpProcess;

  @override
  List<Object?> get props => [];
}

class _Initial extends SignUpState {
  const _Initial();
}

class _Loading extends SignUpState {
  const _Loading();
}

@autoequal
class _Error extends SignUpState {
  final String errorMessage;
  const _Error(this.errorMessage) : super();

  @override
  List<Object?> get props => _$props;
}

@CopyWith()
@autoequal
class _SignUpProcess extends SignUpState {
  final SignUpStatus signUpStatus;
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
  final String? birthday;
  final bool tosAccepted;
  const _SignUpProcess({
    required this.signUpStatus,
    required this.isObscured,
    required this.hasSixCharacters,
    required this.hasSpecialCharacter,
    required this.hasLowerUpperCase,
    required this.hasNumber,
    required this.isMatching,
    required this.isConfirmObscured,
    required this.tosAccepted,
    this.email,
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
    this.birthday,
  }) : super();

  @override
  List<Object?> get props => _$props;
}
