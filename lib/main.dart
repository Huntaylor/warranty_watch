import 'package:warranty_keeper/modules/bloc/cubit/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/bloc/home_view/home_view_bloc.dart';
import 'package:warranty_keeper/modules/bloc/main/main_cubit.dart';
import 'package:warranty_keeper/modules/bloc/new_warranty/new_warranty_cubit.dart';

import 'package:warranty_keeper/modules/cubit/nav_cubit.dart';
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
        BlocProvider<HomeViewBloc>(
          create: (context) => HomeViewBloc(),
        ),
        BlocProvider<NavCubit>(
          create: (context) => NavCubit(),
        ),
        BlocProvider<NewWarrantyCubit>(
          create: (context) => NewWarrantyCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: AppNavigator.rootNavigatorKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Warranty Keeper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeView(),
        routes: appRoutes,
      ),
    );
  }
}
