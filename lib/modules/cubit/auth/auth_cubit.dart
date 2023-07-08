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

  setInitial() {
    emit(const _Initial());
  }

  Future checkEmail(String email) async {
    try {
      emit(const _Loading());

      final isUsed = await _authRepository.isEmailAlreadyInUse(email);

      if (isUsed) {
        emit(
          const _Error(
            'This email already has an account. Please sign in instead.',
          ),
        );
      } else {
        emit(const _NotAuthenticated());
      }
    } catch (e) {
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      emit(const _Loading());
      await _authRepository.login(email, password);
      WarrantyUser currentUser = _authRepository.currentUser();
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
      WarrantyUser currentUser = _authRepository.currentUser();
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
      WarrantyUser currentUser = _authRepository.currentUser();
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
        WarrantyUser currentUser = _authRepository.currentUser();
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

  Future updatePersonalData(String firstName, String lastName, String age) async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.updatePersonalData(
        firstName,
        lastName,
        age,
      );

      WarrantyUser currentUser = _authRepository.currentUser();
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
