import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/paths/paths.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/forgot_password/forgot_password_view.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/presentation/login/login_view.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_keeper/presentation/settings/settings_view.dart';
import 'package:warranty_keeper/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_keeper/utils/app_navigator.dart';

import 'modules/cubit/auth/auth_cubit.dart';

final goRoutes = GoRouter(
  navigatorKey: AppNavigator.rootNavigatorKey,
  initialLocation: Paths.login.goRoute,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Paths.home.goRoute,
      builder: (_, __) => const HomeView(),
      routes: [
        GoRoute(
          path: Paths.home.newWarranty.goRoute,
          builder: (_, __) => const NewWarrantyView(),
        ),
        GoRoute(
          path: Paths.home.currentWarranty.goRoute,
          builder: (_, __) => const CurrentWarrantiesView(),
        ),
        GoRoute(
          path: Paths.home.warrantyDetails.goRoute,
          builder: (_, __) => const WarrantyDetailsView(),
        ),
        GoRoute(
          path: Paths.home.settings.goRoute,
          builder: (_, __) => const SettingsView(),
        ),
      ],
    ),
    GoRoute(
      routes: [
        GoRoute(
          path: Paths.login.forgotPassword.goRoute,
          builder: (_, __) => const ForgotPasswordView(),
        ),
      ],
      path: Paths.login.goRoute,
      builder: (_, __) => const LoginView(),
    ),
  ],
  redirect: (context, state) {
    final currentLocation = state.location;

    final auth = context.read<AuthCubit>().state;

    if (auth.isAuthenticated) {
      if (currentLocation.startsWith(Paths.login.goRoute)) {
        return Paths.home.path;
      }

      return null;
    }

    if (!currentLocation.startsWith(Paths.login.goRoute)) {
      return Paths.login.path;
    }

    return null;
  },
);
