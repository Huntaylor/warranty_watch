import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_keeper/app_library.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.g.dart';

enum SignUpStatus { signUp, personalData, tos }

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const _Initial()) {
    getInitial();
  }

  getInitial() {
    emit(
      const _SignUpProcess(
        signUpStatus: SignUpStatus.signUp,
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

  toggleTosAccepted(bool value) {
    emit(
      state.asSignUp.copyWith(
        tosAccepted: value,
      ),
    );
  }

  bool arePasswordRequirementsMet() {
    final passwordRequirement = state.asSignUp;
    return (passwordRequirement.hasLowerUpperCase &&
        passwordRequirement.hasNumber &&
        passwordRequirement.hasSixCharacters &&
        passwordRequirement.isMatching &&
        passwordRequirement.hasSpecialCharacter);
  }

  changeEmail(String email) {
    emit(
      state.asSignUp.copyWith(
        email: email,
      ),
    );
    enabledRegister();
    enabledEmailNext();
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
    enabledEmailNext();
  }

  pushPersonalData() {
    emit(
      state.asSignUp.copyWith(
        signUpStatus: SignUpStatus.personalData,
      ),
    );
  }

  pushTos() {
    emit(
      state.asSignUp.copyWith(
        signUpStatus: SignUpStatus.tos,
      ),
    );
  }

  onSignUpBack() {
    if (state.asSignUp.signUpStatus == SignUpStatus.tos) {
      emit(
        state.asSignUp.copyWith(
          signUpStatus: SignUpStatus.personalData,
        ),
      );
    } else if (state.asSignUp.signUpStatus == SignUpStatus.personalData) {
      emit(
        state.asSignUp.copyWith(
          signUpStatus: SignUpStatus.signUp,
        ),
      );
    }
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
        confirmPassword: confirmPassword,
      ),
    );
    enabledRegister();
    enabledEmailNext();
  }

  changeFirstName(String firstName) {
    emit(
      state.asSignUp.copyWith(
        firstName: firstName,
      ),
    );
    enabledRegister();
  }

  changeLastName(String lastName) {
    emit(
      state.asSignUp.copyWith(
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
    return true;
  }

  bool enabledEmailNext() {
    if (state.asSignUp.email == null || state.asSignUp.email!.isEmpty) return false;
    if (state.asSignUp.password == null || state.asSignUp.password!.isEmpty) return false;
    if (state.asSignUp.confirmPassword == null || state.asSignUp.confirmPassword!.isEmpty) return false;
    if (!arePasswordRequirementsMet()) return false;
    return true;
  }

  bool enabledDataNext() {
    if (state.asSignUp.firstName == null || state.asSignUp.firstName!.isEmpty) return false;
    if (state.asSignUp.lastName == null || state.asSignUp.lastName!.isEmpty) return false;
    return true;
  }

  bool enabledTosNext() {
    if (!state.asSignUp.tosAccepted) return false;
    return true;
  }
}
