import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_watch/app/presentation/forgot_password/forgot_password_view.dart';
import 'package:warranty_watch/app/presentation/home/home_view.dart';
import 'package:warranty_watch/app/presentation/login/login_view_v2.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_watch/app/presentation/settings/settings_view.dart';
import 'package:warranty_watch/app/presentation/sign_up/sign_up_initial_view.dart';
import 'package:warranty_watch/app/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';

final goRoutes = GoRouter(
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
          path: Paths.home.warranties.goRoute,
          builder: (_, __) => const CurrentWarrantiesView(),
          routes: [
            GoRoute(
              path: Paths.home.warranties.details.goRoute,
              builder: (_, __) => const WarrantyDetailsView(),
            ),
          ],
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
        GoRoute(
          path: Paths.login.register.goRoute,
          builder: (_, __) => const SignUpInitialView(),
        ),
      ],
      path: Paths.login.goRoute,
      builder: (_, __) => const LoginViewV2(),
    ),
  ],
  redirect: (context, state) {
    final currentLocation = state.uri.toString();

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
