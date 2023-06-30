import 'package:autoequal/autoequal.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.g.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future login(String email, String password) async {
    try {
      emit(
        const AuthLoading(),
      );
      await _authRepository.login(email, password);
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          Authenticated(currentUser),
        );
      } else {
        emit(
          const NotAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future loginWithGoogle() async {
    try {
      emit(const AuthLoading());
      await _authRepository.signInWithGoogle();
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(Authenticated(currentUser));
      } else {
        emit(const NotAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future register(String email, String password) async {
    try {
      emit(
        const AuthLoading(),
      );
      await _authRepository.register(email, password);
      User currentUser = _authRepository.currentUser();
      emit(
        Authenticated(currentUser),
      );
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future logout() async {
    try {
      emit(
        const AuthLoading(),
      );
      await _authRepository.logout();
      emit(
        const NotAuthenticated(),
      );
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future submitPasswordReset(String email) async {
    try {
      emit(
        const AuthLoading(),
      );
      await _authRepository.passwordResetSubmit(email);
      emit(
        const PasswordRequestSubmitted(),
      );
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  void isLoggedIn() {
    try {
      emit(
        const AuthLoading(),
      );
      if (_authRepository.currentUser().uid != null) {
        User currentUser = _authRepository.currentUser();
        emit(
          Authenticated(currentUser),
        );
      } else {
        emit(
          const NotAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future isFirstRun() async {
    try {
      emit(
        const AuthLoading(),
      );
      if (await _authRepository.isFirstRun()) {
        emit(
          const FirstRun(),
        );
      } else {
        User currentUser = _authRepository.currentUser();
        emit(
          Authenticated(currentUser),
        );
      }
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future updatePersonalData(String firstName, String lastName, String birthday) async {
    try {
      emit(
        const AuthLoading(),
      );
      await _authRepository.updatePersonalData(
        firstName,
        lastName,
        birthday,
      );
      emit(
        const PersonalDataUpdated(),
      );
    } catch (e) {
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }
}
