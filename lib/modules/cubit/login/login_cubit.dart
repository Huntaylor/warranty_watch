import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  toggleObscurity() {
    emit(
      state.copyWith(
        isObscured: !state.isObscured,
        email: state.email,
        password: state.password,
      ),
    );
  }

  changeEmail(String email) {
    emit(
      state.copyWith(
        email: email,
        isObscured: state.isObscured,
        password: state.password,
      ),
    );
    enabledLogin();
  }

  changePassword(String password) {
    emit(
      state.copyWith(
        email: state.email,
        isObscured: state.isObscured,
        password: password,
      ),
    );
    enabledLogin();
  }

  bool enabledLogin() {
    if (state.email.isEmpty) return false;
    if (state.password.isEmpty) return false;
    return true;
  }
}
