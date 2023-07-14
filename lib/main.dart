import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warranty_keeper/data/interfaces/iwarranties_source.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/home/home_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'data/repositories/warranty_repository.dart';
import 'firebase_options.dart';

import 'package:warranty_keeper/go_routes.dart';

import 'app_library.dart';

void main() async {
  // const webRecaptchaSiteKey = '';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.debug);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.system;

    const FlexScheme usedScheme = FlexScheme.deepBlue;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(FirebaseAuthRepository()),
        ),
        BlocProvider<NewWarrantyCubit>(
          create: (context) => NewWarrantyCubit(FirebaseDataRepository()),
        ),
        BlocProvider<CurrentWarrantiesCubit>(
          create: (context) => CurrentWarrantiesCubit(
            warrantyRepository: FirebaseDataRepository(),
            warrantiesSource: WarrantiesSource(),
          ),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
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
