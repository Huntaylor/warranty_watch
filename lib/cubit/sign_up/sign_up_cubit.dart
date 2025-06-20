import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_watch/app/app_library.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.g.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const _Initial()) {
    getInitial();
  }

  void getInitial() {
    emit(
      const _SignUpProcess(
        tosAccepted: false,
        isConfirmObscured: true,
        isMatching: false,
        isObscured: true,
        hasLowerUpperCase: false,
        hasNumber: false,
        hasSixCharacters: false,
        hasSpecialCharacter: false,
      ),
    );
  }

  void toggleObscurity() {
    emit(
      state.asSignUp.copyWith(
        isObscured: !state.asSignUp.isObscured,
      ),
    );
  }

  void toggleConfirmObscurity() {
    emit(
      state.asSignUp.copyWith(
        isConfirmObscured: !state.asSignUp.isConfirmObscured,
      ),
    );
  }

  void toggleTosAccepted({bool? value}) {
    emit(
      state.asSignUp.copyWith(
        tosAccepted: value,
      ),
    );
  }

  bool arePasswordRequirementsMet() {
    final passwordRequirement = state.asSignUp;
    return passwordRequirement.hasLowerUpperCase &&
        passwordRequirement.hasNumber &&
        passwordRequirement.hasSixCharacters &&
        passwordRequirement.isMatching &&
        passwordRequirement.hasSpecialCharacter;
  }

  void changeEmail(String email) {
    emit(
      state.asSignUp.copyWith(
        email: email.trim(),
      ),
    );
    enabledRegister();
  }

  void changePassword(String password) {
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

    if (password.contains(RegExp('^(?=.*?[A-Z])(?=.*?[a-z])'))) {
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

    if (password.contains(RegExp('^(?=.*[^A-Za-z0-9_])'))) {
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
    if (password.contains(RegExp('^(?=.*[0-9])'))) {
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
        password: password.trim(),
      ),
    );
    enabledRegister();
  }

  void changeConfirmPassword(String confirmPassword) {
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
        confirmPassword: confirmPassword.trim(),
      ),
    );
    enabledRegister();
  }

  void changeFirstName(String firstName) {
    emit(
      state.asSignUp.copyWith(
        firstName: firstName.trim(),
      ),
    );
    enabledRegister();
  }

  void changeLastName(String lastName) {
    emit(
      state.asSignUp.copyWith(
        lastName: lastName.trim(),
      ),
    );
    enabledRegister();
  }

  bool enabledRegister() {
    if (state.asSignUp.email == null || state.asSignUp.email!.isEmpty) {
      return false;
    }
    if (state.asSignUp.password == null || state.asSignUp.password!.isEmpty) {
      return false;
    }
    if (state.asSignUp.confirmPassword == null ||
        state.asSignUp.confirmPassword!.isEmpty) {
      return false;
    }
    if (state.asSignUp.firstName == null || state.asSignUp.firstName!.isEmpty) {
      return false;
    }
    if (state.asSignUp.lastName == null || state.asSignUp.lastName!.isEmpty) {
      return false;
    }
    if (state.asSignUp.tosAccepted == false) {
      return false;
    }
    return true;
  }
}
