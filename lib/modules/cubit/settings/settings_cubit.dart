import 'package:autoequal/autoequal.dart';
import 'package:warranty_keeper/app_library.dart';

part 'settings_state.dart';
part 'settings_cubit.g.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const _Initial());

  toggleNotifications(bool value) {
    emit(
      _SetSettings(
        isNotifications: value,
      ),
    );
  }

  toggleSomething(bool value) {
    //TODO add function
    emit(
      _SetSettings(
        isSomething: value,
      ),
    );
  }
}
