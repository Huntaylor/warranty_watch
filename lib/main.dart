import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warranty_keeper/data/data_sources.dart/firebase_data_source.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'data/repositories/warranty_repository.dart';
import 'firebase_options.dart';

import 'package:warranty_keeper/routes/go_routes.dart';

import 'app_library.dart';

void main() async {
  // const webRecaptchaSiteKey = '';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAPI().initNotifications();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.system;

    // const usedScheme = FlexScheme.deepBlue;
    // const usedScheme = FlexScheme.flutterDash;
    const usedScheme = FlexScheme.blue;
    // const usedScheme = FlexScheme.aquaBlue;
    // const usedScheme = FlexScheme.brandBlue;
    // const usedScheme = FlexScheme.hippieBlue;
    // const usedScheme = FlexScheme.bahamaBlue;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(FirebaseAuthRepository()),
        ),
        BlocProvider<WarrantiesCubit>(
          create: (context) => WarrantiesCubit(
            dataRepository: DataRepository(),
            authRepository: FirebaseAuthRepository(),
          ),
        ),
        BlocProvider<WarrantyDetailsCubit>(
          create: (context) => WarrantyDetailsCubit(),
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
        title: 'Warranty Tracker',
        theme: FlexThemeData.light(
          scheme: usedScheme,
          appBarElevation: 0.5,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: usedScheme,
          appBarElevation: 2,
        ),
        themeMode: themeMode,
        routerConfig: goRoutes,
      ),
    );
  }
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}
