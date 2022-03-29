import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(const AuthState.initial());

  Future login(String email, String password) async {
    try {
      emit(
        const AuthState.loading(
          isApple: false,
          isEmail: true,
          isGmail: false,
        ),
      );
      await _authRepository.login(email.trim(), password.trim());
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          AuthState.authenticated(user: currentUser),
        );
      } else {
        emit(
          const AuthState.notAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future loginWithGoogle() async {
    try {
      emit(
        const AuthState.loading(
          isApple: false,
          isEmail: false,
          isGmail: true,
        ),
      );
      await _authRepository.signInWithGoogle();
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          AuthState.authenticated(
            user: currentUser,
          ),
        );
      } else {
        emit(
          const AuthState.notAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future loginWithApple() async {
    try {
      emit(
        const AuthState.loading(
          isApple: true,
          isEmail: false,
          isGmail: false,
        ),
      );
      await _authRepository.signinWithApple();
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          AuthState.authenticated(
            user: currentUser,
          ),
        );
      } else {
        emit(
          const AuthState.notAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future loginWithFacebook() async {
    try {
      emit(
        const AuthState.loading(
          isApple: false,
          isEmail: false,
          isGmail: true,
        ),
      );
      await _authRepository.signInWithGoogle();
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          AuthState.authenticated(
            user: currentUser,
          ),
        );
      } else {
        emit(
          //TODO: change back to authenticated if there is a problem
          const AuthState.notAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future register(String email, String password) async {
    try {
      emit(
        const AuthState.loading(),
      );
      await _authRepository.register(email, password);
      User currentUser = _authRepository.currentUser();
      emit(
        AuthState.authenticated(user: currentUser),
      );
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future logout() async {
    try {
      emit(
        const AuthState.loading(),
      );
      await _authRepository.logout();
      emit(
        //TODO: change back to authenticated if there is a problem
        const AuthState.notAuthenticated(),
      );
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future submitPasswordReset(String email) async {
    try {
      emit(
        const AuthState.loading(),
      );
      await _authRepository.passwordResetSubmit(email);
      emit(
        const AuthState.passwordRequestSubmitted(),
      );
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  void isLoggedIn() {
    try {
      emit(
        const AuthState.loading(),
      );
      if (_authRepository.currentUser().uid != null) {
        User currentUser = _authRepository.currentUser();
        emit(
          AuthState.authenticated(user: currentUser),
        );
      } else {
        emit(
          const AuthState.authenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future isFirstRun() async {
    try {
      emit(
        const AuthState.loading(),
      );
      if (await _authRepository.isFirstRun()) {
        emit(
          const AuthState.firstRun(),
        );
      } else {
        User currentUser = _authRepository.currentUser();
        emit(
          AuthState.authenticated(user: currentUser),
        );
      }
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }

  Future updatePersonalData(
      String firstName, String lastName, String birthday) async {
    try {
      emit(
        const AuthState.loading(),
      );
      await _authRepository.updatePersonalData(
        firstName,
        lastName,
        birthday,
      );
      emit(
        const AuthState.personalDataUpdated(),
      );
    } catch (e) {
      emit(
        AuthState.error(
          message: e.toString(),
        ),
      );
    }
  }
}
