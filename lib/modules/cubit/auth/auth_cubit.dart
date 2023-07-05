import 'package:autoequal/autoequal.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.g.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(const _Loading()) {
    isLoggedIn();
  }

  Future login(String email, String password) async {
    try {
      emit(const _Loading());
      await _authRepository.login(email, password);
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          _Authenticated(currentUser),
        );
      } else {
        emit(
          const _NotAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future loginWithGoogle() async {
    try {
      emit(const _Loading());
      await _authRepository.signInWithGoogle();
      User currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(_Authenticated(currentUser));
      } else {
        emit(const _NotAuthenticated());
      }
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future register(String email, String password) async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.register(email, password);
      User currentUser = _authRepository.currentUser();
      emit(
        _Authenticated(currentUser),
      );
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future logout() async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.logout();
      emit(
        const _NotAuthenticated(),
      );
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future submitPasswordReset(String email) async {
    try {
      emit(const _Loading());
      await _authRepository.passwordResetSubmit(email);
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  void isLoggedIn() {
    try {
      emit(
        const _Loading(),
      );
      if (_authRepository.currentUser().uid != null) {
        User currentUser = _authRepository.currentUser();
        emit(
          _Authenticated(currentUser),
        );
      } else {
        emit(
          const _NotAuthenticated(),
        );
      }
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future updatePersonalData(String firstName, String lastName, String birthday) async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.updatePersonalData(
        firstName,
        lastName,
        birthday,
      );

      User currentUser = _authRepository.currentUser();
      emit(
        _Authenticated(currentUser),
      );
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }
}
