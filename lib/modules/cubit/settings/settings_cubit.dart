import 'package:autoequal/autoequal.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_watch/app/app_library.dart';

part 'settings_state.dart';
part 'settings_cubit.g.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const _SetSettings(
            isNotifications: false,
            isSomething: false,
          ),
        ) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    final isNotifcationsAllowed =
        await AwesomeNotifications().isNotificationAllowed();

    emit(
      _SetSettings(
        isNotifications: isNotifcationsAllowed,
        isSomething: false,
      ),
    );
  }

  Future<void> checkNotifications() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      emit(
        state.asSet.copyWith(
          isNotifications: isAllowed,
        ),
      );
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications().then(
              (value) => emit(
                state.asSet.copyWith(
                  isNotifications: value,
                ),
              ),
            );
      }
    });
  }

  Future<void> toggleNotifications({required bool value}) async {
    await checkNotifications();
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
