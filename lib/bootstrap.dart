import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/firebase_options.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  static final Logger _log = Logger('Bloc Observer');

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _log.log(Level.INFO, 'onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log.log(
      Level.WARNING,
      'onError(${bloc.runtimeType}, $error, $stackTrace)',
    );
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(Widget Function() builder) async {
  final log = Logger('Bootstrap');

  FlutterError.onError = (details) {
    log.log(
      Level.WARNING,
      details.exceptionAsString(),
      details,
      details.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelGroupKey: 'reminder_channel_group',
        channelKey: 'reminder_channel',
        channelName: 'Warranty Reminder notifications',
        channelDescription: 'Notification channel for reminders',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
      NotificationChannel(
        channelGroupKey: 'expired_channel_group',
        channelKey: 'expired_channel',
        channelName: 'Expired Warranty Notification',
        channelDescription: 'Notification channel for expired warranties',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'expired_channel_group',
        channelGroupName: 'Expired Warranty group',
      ),
      NotificationChannelGroup(
        channelGroupKey: 'reminder_channel_group',
        channelGroupName: 'Warranty Reminder group',
      ),
    ],
    debug: true,
  );

  runApp(builder());
}
