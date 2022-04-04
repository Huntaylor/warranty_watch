import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.initial());

  toggleObscurity() {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: !state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
  }

  toggleConfirmObscurity() {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: !state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
  }

  changeEmail(String email) {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeBirthday(String birthday) {
    emit(
      state.copyWith(
        birthday: birthday,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
    enabledRegister();
  }

  changePassword(String password) {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeConfirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: state.password,
        confirmPassword: confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: state.lastName,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeFirstName(String firstName) {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: firstName,
        lastName: state.lastName,
      ),
    );
    enabledRegister();
  }

  changeLastName(String lastName) {
    emit(
      state.copyWith(
        birthday: state.birthday,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
        isConfirmObscured: state.isConfirmObscured,
        isObscured: state.isObscured,
        firstName: state.firstName,
        lastName: lastName,
      ),
    );
    enabledRegister();
  }

  bool enabledRegister() {
    if (state.email.isEmpty) return false;
    if (state.password.isEmpty) return false;
    if (state.confirmPassword.isEmpty) return false;
    if (state.firstName.isEmpty) return false;
    if (state.lastName.isEmpty) return false;
    if (state.birthday.isEmpty) return false;
    return true;
  }

  bool enabledNext() {
    if (state.email.isEmpty) return false;
    if (state.password.isEmpty) return false;
    if (state.confirmPassword.isEmpty) return false;
    return true;
  }
}
