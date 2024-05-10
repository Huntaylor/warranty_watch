import 'package:app_settings/app_settings.dart';
import 'package:app_settings/app_settings_platform_interface.dart';
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
            isNotificationAllowed: false,
            isSomething: false,
          ),
        ) {
    AppLifecycleListener(
      onResume: checkNotifications,
    );

    getNotifications();
  }

  Future<void> getNotifications() async {
    final isNotifcationAllowed =
        await AwesomeNotifications().isNotificationAllowed();

    emit(
      _SetSettings(
        isNotificationEnabled: isNotifcationAllowed,
        isNotificationAllowed: isNotifcationAllowed,
        isSomething: false,
      ),
    );
  }

  Future<void> checkNotifications() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      emit(
        state.asSet.copyWith(
          isNotificationEnabled: isAllowed,
          isNotificationAllowed: isAllowed,
        ),
      );
    });
  }

  Future<void> toggleNotifications({required bool value}) async {
    await AppSettingsPlatform.instance
        .openAppSettings(type: AppSettingsType.notification);
    emit(
      state.asSet.copyWith(
        isNotificationAllowed: value,
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
