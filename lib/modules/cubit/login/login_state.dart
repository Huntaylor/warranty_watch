part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(true) bool isObscured,
    @Default('') String email,
    @Default('') String password,
  }) = _Initial;
}
