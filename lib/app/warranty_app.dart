import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/auth_repository.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/routes/go_routes.dart';
import 'package:warranty_watch/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/cubit/settings/settings_cubit.dart';
import 'package:warranty_watch/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/cubit/warranty_details/warranty_details_cubit.dart';

class WarrantyApp extends StatefulWidget {
  const WarrantyApp({
    super.key,
  });

  @override
  State<WarrantyApp> createState() => _WarrantyAppState();
}

class _WarrantyAppState extends State<WarrantyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const usedScheme = FlexScheme.blue;

    final authRepo = FirebaseAuthRepository();
    final authCubit = AuthCubit(
      authRepo,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => authCubit),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        // BlocProvider<WarrantiesCubit>(
        //   create: (context) => WarrantiesCubit(
        //     authStateStream: authCubit.stream,
        //     dataRepository: DataRepository(),
        //     authRepository: authRepo,
        //   ),
        // ),
        BlocProvider<WarrantyDetailsCubit>(
          create: (context) => WarrantyDetailsCubit(),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => authRepo,
          ),
          RepositoryProvider<DataRepository>(
            create: (context) => DataRepository(),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
          title: 'Warranty Watch',
          theme: FlexThemeData.light(
            textTheme: GoogleFonts.robotoTextTheme(context.textTheme),
            scheme: usedScheme,
            appBarElevation: 0.5,
          ),
          // darkTheme: FlexThemeData.dark(
          //   textTheme: GoogleFonts.robotoTextTheme(context.textTheme),
          //   scheme: usedScheme,
          //   appBarElevation: 2,
          // ),
          routerConfig: goRoutes,
        ),
      ),
    );
  }
}

class NotificationController {
  /// Use this method to detect when the user
  ///  taps on a notification or action button
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // This will be set up to display the warranty tied to the notification
  }
}
