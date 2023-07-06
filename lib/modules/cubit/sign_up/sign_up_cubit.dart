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
    if (password.length >= 6) {
      emit(
        state.copyWith(
          hasSixCharacters: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          hasSixCharacters: false,
        ),
      );
    }

    if (password.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])'))) {
      emit(
        state.copyWith(
          hasLowerUpperCase: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          hasLowerUpperCase: false,
        ),
      );
    }

    if (password.contains(RegExp(r'^(?=.*[^A-Za-z0-9_])'))) {
      emit(
        state.copyWith(
          hasSpecialCharacter: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          hasSpecialCharacter: false,
        ),
      );
    }
    if (password.contains(RegExp(r'^(?=.*[0-9])'))) {
      emit(
        state.copyWith(
          hasNumber: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          hasNumber: false,
        ),
      );
    }

    emit(
      state.copyWith(
        password: password,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeConfirmPassword(String confirmPassword) {
    if (confirmPassword == state.password) {
      emit(
        state.copyWith(
          isMatching: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isMatching: false,
        ),
      );
    }
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
