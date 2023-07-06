part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial({
    @Default(true) bool isObscured,
    @Default(false) bool hasSixCharacters,
    @Default(false) bool hasSpecialCharacter,
    @Default(false) bool hasLowerUpperCase,
    @Default(false) bool hasNumber,
    @Default(false) bool isMatching,
    @Default(true) bool isConfirmObscured,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String birthday,
  }) = _Initial;
}
