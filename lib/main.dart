import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:warranty_keeper/data/interfaces/iwarranties_source.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/home/home_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/modules/cubit/main/main_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/settings/settings_cubit.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
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
        BlocProvider<MainCubit>(
          create: (context) => MainCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(FirebaseAuthRepository()),
        ),
        BlocProvider<CurrentWarrantiesCubit>(
          create: (context) => CurrentWarrantiesCubit(
            warrantiesSource: WarrantiesSource(),
          ),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<NewWarrantyCubit>(
          create: (context) => NewWarrantyCubit(),
        ),
        BlocProvider<WarrantyDetailsCubit>(
          create: (context) => WarrantyDetailsCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
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

        // darkTheme: FlexThemeData.dark(
        //   colors: const FlexSchemeColor(
        //     primary: Color(0xff5b7cb5),
        //     primaryVariant: Color(0xff5a6f94),
        //     secondary: Color(0xffc15c5c),
        //     secondaryVariant: Color(0xffa15a5a),
        //     appBarColor: Color(0xffa15a5a),
        //     error: null,
        //   ),
        //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        //   blendLevel: 18,
        //   appBarStyle: FlexAppBarStyle.background,
        //   appBarOpacity: 0.95,
        //   appBarElevation: 0,
        //   transparentStatusBar: true,
        //   tabBarStyle: FlexTabBarStyle.forAppBar,
        //   tooltipsMatchBackground: true,
        //   swapColors: false,
        //   darkIsTrueBlack: false,
        //   useSubThemes: true,
        //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //   fontFamily: GoogleFonts.notoSans().fontFamily,
        //   subThemesData: const FlexSubThemesData(
        //     useTextTheme: true,
        //     fabUseShape: true,
        //     interactionEffects: true,
        //     bottomNavigationBarElevation: 0,
        //     bottomNavigationBarOpacity: 0.95,
        //     navigationBarOpacity: 0.95,
        //     navigationBarMutedUnselectedText: true,
        //     navigationBarMutedUnselectedIcon: true,
        //     inputDecoratorIsFilled: true,
        //     inputDecoratorBorderType: FlexInputBorderType.outline,
        //     inputDecoratorUnfocusedHasBorder: true,
        //     blendOnColors: true,
        //     blendTextTheme: true,
        //     popupMenuOpacity: 0.95,
        //   ),
        // ),
        // theme: FlexThemeData.light(
        //   colors: const FlexSchemeColor(
        //     primary: Color(0xff04368e),
        //     primaryVariant: Color(0xff03235c),
        //     secondary: Color(0xffa00505),
        //     secondaryVariant: Color(0xff6f0303),
        //     appBarColor: Color(0xff6f0303),
        //     error: null,
        //   ),
        //   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        //   blendLevel: 18,
        //   appBarStyle: FlexAppBarStyle.primary,
        //   appBarOpacity: 0.95,
        //   appBarElevation: 0,
        //   transparentStatusBar: true,
        //   tabBarStyle: FlexTabBarStyle.forAppBar,
        //   tooltipsMatchBackground: true,
        //   swapColors: false,
        //   lightIsWhite: false,
        //   useSubThemes: true,
        //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //   fontFamily: GoogleFonts.notoSans().fontFamily,
        //   subThemesData: const FlexSubThemesData(
        //     useTextTheme: true,
        //     fabUseShape: true,
        //     interactionEffects: true,
        //     bottomNavigationBarElevation: 0,
        //     bottomNavigationBarOpacity: 0.95,
        //     navigationBarOpacity: 0.95,
        //     navigationBarMutedUnselectedText: true,
        //     navigationBarMutedUnselectedIcon: true,
        //     inputDecoratorIsFilled: true,
        //     inputDecoratorBorderType: FlexInputBorderType.outline,
        //     inputDecoratorUnfocusedHasBorder: true,
        //     blendOnColors: true,
        //     blendTextTheme: true,
        //     popupMenuOpacity: 0.95,
        //   ),
        // ),
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ).copyWith(
        //   pageTransitionsTheme: const PageTransitionsTheme(
        //     builders: <TargetPlatform, PageTransitionsBuilder>{
        //       TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        //       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //     },
        //   ),
        // ),
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
