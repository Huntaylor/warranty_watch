import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_watch/app/app_library.dart';

part 'settings_state.dart';
part 'settings_cubit.g.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const _Initial()) {
    getNotifications();
  }

  void getNotifications() {
    // TODO(huntaylor):  GET DATA FROM FIREBASE
    emit(
      const _SetSettings(
        isNotifications: false,
        isSomething: false,
      ),
    );
  }

  void toggleNotifications({required bool value}) {
    emit(
      state.asSet.copyWith(
        isNotifications: value,
      ),
    );
  }

  void toggleSomething({required bool value}) {
    // TODO(huntaylor): add function
    emit(
      state.asSet.copyWith(
        isSomething: value,
      ),
    );
  }
}
