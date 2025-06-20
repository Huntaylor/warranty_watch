import 'package:autoequal/autoequal.dart';
import 'package:logging/logging.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/models/user.dart';
import 'package:warranty_watch/app/data/models/user_data.dart';
import 'package:warranty_watch/app/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.g.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository)
      : super(const _Loading(loginType: LoginType.initial)) {
    isLoggedIn();
  }
  static final Logger _log = Logger('Auth Cubit');
  final AuthRepository _authRepository;

  void clearError() {
    emit(const _Initial());
  }

  Future<void> deleteAccount() async {
    try {
      await _authRepository.deleteAccount();
    } on Exception catch (e) {
      _log.info('Firebase Delete Account Error: $e');
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        const _Loading(
          loginType: LoginType.email,
        ),
      );

      await _authRepository.login(email, password);
      final currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(
          _Authenticated(currentUser),
        );
      } else {
        emit(
          const _NotAuthenticated(),
        );
      }
    } on Exception catch (e) {
      _log.info('Firebase Login Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(
        const _Loading(
          loginType: LoginType.google,
        ),
      );
      await _authRepository.signInWithGoogle();
      final currentUser = _authRepository.currentUser();
      if (currentUser.uid != null) {
        emit(_Authenticated(currentUser));
      } else {
        emit(const _NotAuthenticated());
      }
    } on Exception catch (e) {
      _log.info('Firebase Google Login Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future<void> register(
    String email,
    String password,
    UserData userData,
  ) async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.register(
        email,
        password,
        userData,
      );
      final currentUser = _authRepository.currentUser();
      emit(
        _Authenticated(currentUser),
      );
    } on Exception catch (e) {
      _log.info('Firebase Register Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.logout();

      emit(
        const _NotAuthenticated(),
      );
    } on Exception catch (e) {
      _log.info('Firebase Logout Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future<void> submitPasswordReset(String email) async {
    try {
      emit(const _Loading());
      await _authRepository.passwordResetSubmit(email).then(
            (value) => emit(
              const _EmailSuccess(),
            ),
          );
    } on Exception catch (e) {
      _log.info('Firebase Reset Password Error: $e');
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
        final currentUser = _authRepository.currentUser();
        emit(
          _Authenticated(currentUser),
        );
      } else {
        emit(
          const _NotAuthenticated(),
        );
      }
    } on Exception catch (e) {
      _log.info('Firebase Is Login Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }

  Future<void> updatePersonalData(UserData userData) async {
    try {
      emit(
        const _Loading(),
      );
      await _authRepository.updatePersonalData(userData);

      final currentUser = _authRepository.currentUser();
      emit(
        _Authenticated(currentUser),
      );
    } on Exception catch (e) {
      _log.info('Firebase Update info Error: $e');
      emit(
        _Error(
          e.toString(),
        ),
      );
    }
  }
}
