import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/current_warranties/user_warranties_view.dart';
import 'package:warranty_watch/app/presentation/forgot_password/forgot_password_view.dart';
import 'package:warranty_watch/app/presentation/home/warranty_home_view.dart';
import 'package:warranty_watch/app/presentation/login/login_view.dart';
import 'package:warranty_watch/app/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_watch/app/presentation/settings/settings_view.dart';
import 'package:warranty_watch/app/presentation/sign_up/sign_up_view.dart';
import 'package:warranty_watch/app/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';

final goRoutes = GoRouter(
  initialLocation: Paths.login.goRoute,
  debugLogDiagnostics: true,
  routes: [
    goRouteFade(
      path: Paths.home.goRoute,
      pageBuilder: (_, __) => const WarrantyHomeView(),
      routes: [
        goRouteSlide(
          path: Paths.home.newWarranty.goRoute,
          pageBuilder: (_, __) => const NewWarrantyView(),
        ),
        goRouteSlide(
          path: Paths.home.warranties.goRoute,
          pageBuilder: (_, __) => const UserWarrantiesView(),
          routes: [
            goRouteSlide(
              path: Paths.home.warranties.details.goRoute,
              pageBuilder: (_, __) => const WarrantyDetailsView(),
            ),
          ],
        ),
        goRouteSlide(
          path: Paths.home.settings.goRoute,
          pageBuilder: (_, __) => const SettingsView(),
        ),
      ],
    ),
    goRouteSlide(
      routes: [
        goRouteSlide(
          path: Paths.login.forgotPassword.goRoute,
          pageBuilder: (_, __) => const ForgotPasswordView(),
        ),
        goRouteSlide(
          path: Paths.login.register.goRoute,
          pageBuilder: (_, __) => const SignUpView(),
        ),
      ],
      path: Paths.login.goRoute,
      pageBuilder: (_, __) => const LoginViewV2(),
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

GoRoute goRouteSlide({
  required String path,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
  List<RouteBase>? routes,
}) {
  return GoRoute(
    routes: routes ?? [],
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: pageBuilder(context, state),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(
            curve: curve,
          ),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

GoRoute goRouteFade({
  required String path,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
  List<RouteBase>? routes,
}) {
  return GoRoute(
    routes: routes ?? [],
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: pageBuilder(context, state),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}
