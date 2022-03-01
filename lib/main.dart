import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/home/home_cubit.dart';
import 'package:warranty_keeper/modules/cubit/main/main_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/settings/settings_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';

import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/routes.dart';
import 'package:warranty_keeper/utils/app_navigator.dart';

import 'app_library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit(),
        ),
        BlocProvider<CurrentWarrantiesCubit>(
          create: (context) => CurrentWarrantiesCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<NavCubit>(
          create: (context) => NavCubit(),
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
      ],
      child: MaterialApp(
        navigatorKey: AppNavigator.rootNavigatorKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Warranty Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: const HomeView(),
        routes: appRoutes,
      ),
    );
  }
}
