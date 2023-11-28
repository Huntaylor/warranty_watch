import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/auth_repository.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/routes/go_routes.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/settings/settings_cubit.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/modules/cubit/warranty_details/warranty_details_cubit.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // const usedScheme = FlexScheme.deepBlue;
    // const usedScheme = FlexScheme.flutterDash;
    const usedScheme = FlexScheme.blue;
    // const usedScheme = FlexScheme.aquaBlue;
    // const usedScheme = FlexScheme.brandBlue;
    // const usedScheme = FlexScheme.hippieBlue;
    // const usedScheme = FlexScheme.bahamaBlue;

    final authRepo = FirebaseAuthRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepo,
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider<WarrantiesCubit>(
          create: (context) => WarrantiesCubit(
            dataRepository: DataRepository(),
            authRepository: authRepo,
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
        title: 'Warranty Watch',
        theme: FlexThemeData.light(
          textTheme: GoogleFonts.robotoTextTheme(context.textTheme),
          scheme: usedScheme,
          appBarElevation: 0.5,
        ),
        darkTheme: FlexThemeData.dark(
          textTheme: GoogleFonts.robotoTextTheme(context.textTheme),
          scheme: usedScheme,
          appBarElevation: 2,
        ),
        routerConfig: goRoutes,
      ),
    );
  }
}
