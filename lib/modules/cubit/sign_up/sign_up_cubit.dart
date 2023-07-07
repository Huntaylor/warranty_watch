import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_keeper/app_library.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.g.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit()
      : super(
          const _SignUpProcess(
            isConfirmObscured: true,
            isMatching: false,
            isObscured: true,
            hasLowerUpperCase: false,
            hasNumber: false,
            hasSixCharacters: false,
            hasSpecialCharacter: false,
          ),
        );

  toggleObscurity() {
    emit(
      state.asSignUp.copyWith(
        isObscured: !state.asSignUp.isObscured,
      ),
    );
  }

  toggleConfirmObscurity() {
    emit(
      state.asSignUp.copyWith(
        isConfirmObscured: !state.asSignUp.isConfirmObscured,
      ),
    );
  }

  changeEmail(String email) {
    emit(
      state.asSignUp.copyWith(
        age: state.asSignUp.age,
        email: email,
        password: state.asSignUp.password,
        confirmPassword: state.asSignUp.confirmPassword,
        isConfirmObscured: state.asSignUp.isConfirmObscured,
        isObscured: state.asSignUp.isObscured,
        firstName: state.asSignUp.firstName,
        lastName: state.asSignUp.lastName,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeage(String age) {
    emit(
      state.asSignUp.copyWith(
        age: age,
        email: state.asSignUp.email,
        password: state.asSignUp.password,
        confirmPassword: state.asSignUp.confirmPassword,
        isConfirmObscured: state.asSignUp.isConfirmObscured,
        isObscured: state.asSignUp.isObscured,
        firstName: state.asSignUp.firstName,
        lastName: state.asSignUp.lastName,
      ),
    );
    enabledRegister();
  }

  changePassword(String password) {
    if (password.length >= 6) {
      emit(
        state.asSignUp.copyWith(
          hasSixCharacters: true,
        ),
      );
    } else {
      emit(
        state.asSignUp.copyWith(
          hasSixCharacters: false,
        ),
      );
    }

    if (password.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])'))) {
      emit(
        state.asSignUp.copyWith(
          hasLowerUpperCase: true,
        ),
      );
    } else {
      emit(
        state.asSignUp.copyWith(
          hasLowerUpperCase: false,
        ),
      );
    }

    if (password.contains(RegExp(r'^(?=.*[^A-Za-z0-9_])'))) {
      emit(
        state.asSignUp.copyWith(
          hasSpecialCharacter: true,
        ),
      );
    } else {
      emit(
        state.asSignUp.copyWith(
          hasSpecialCharacter: false,
        ),
      );
    }
    if (password.contains(RegExp(r'^(?=.*[0-9])'))) {
      emit(
        state.asSignUp.copyWith(
          hasNumber: true,
        ),
      );
    } else {
      emit(
        state.asSignUp.copyWith(
          hasNumber: false,
        ),
      );
    }

    emit(
      state.asSignUp.copyWith(
        password: password,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeConfirmPassword(String confirmPassword) {
    if (confirmPassword == state.asSignUp.password) {
      emit(
        state.asSignUp.copyWith(
          isMatching: true,
        ),
      );
    } else {
      emit(
        state.asSignUp.copyWith(
          isMatching: false,
        ),
      );
    }
    emit(
      state.asSignUp.copyWith(
        age: state.asSignUp.age,
        email: state.asSignUp.email,
        password: state.asSignUp.password,
        confirmPassword: confirmPassword,
        isConfirmObscured: state.asSignUp.isConfirmObscured,
        isObscured: state.asSignUp.isObscured,
        firstName: state.asSignUp.firstName,
        lastName: state.asSignUp.lastName,
      ),
    );
    enabledRegister();
    enabledNext();
  }

  changeFirstName(String firstName) {
    emit(
      state.asSignUp.copyWith(
        age: state.asSignUp.age,
        email: state.asSignUp.email,
        password: state.asSignUp.password,
        confirmPassword: state.asSignUp.confirmPassword,
        isConfirmObscured: state.asSignUp.isConfirmObscured,
        isObscured: state.asSignUp.isObscured,
        firstName: firstName,
        lastName: state.asSignUp.lastName,
      ),
    );
    enabledRegister();
  }

  changeLastName(String lastName) {
    emit(
      state.asSignUp.copyWith(
        age: state.asSignUp.age,
        email: state.asSignUp.email,
        password: state.asSignUp.password,
        confirmPassword: state.asSignUp.confirmPassword,
        isConfirmObscured: state.asSignUp.isConfirmObscured,
        isObscured: state.asSignUp.isObscured,
        firstName: state.asSignUp.firstName,
        lastName: lastName,
      ),
    );
    enabledRegister();
  }

  bool enabledRegister() {
    if (state.asSignUp.email == null || state.asSignUp.email!.isEmpty) return false;
    if (state.asSignUp.password == null || state.asSignUp.password!.isEmpty) return false;
    if (state.asSignUp.confirmPassword == null || state.asSignUp.confirmPassword!.isEmpty) return false;
    if (state.asSignUp.firstName == null || state.asSignUp.firstName!.isEmpty) return false;
    if (state.asSignUp.lastName == null || state.asSignUp.lastName!.isEmpty) return false;
    if (state.asSignUp.age == null || state.asSignUp.age!.isEmpty) return false;
    return true;
  }

  bool enabledNext() {
    if (state.asSignUp.email == null || state.asSignUp.email!.isEmpty) return false;
    if (state.asSignUp.password == null || state.asSignUp.password!.isEmpty) return false;
    if (state.asSignUp.confirmPassword == null || state.asSignUp.confirmPassword!.isEmpty) return false;
    return true;
  }
}
