import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/presentation/login/login_view.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_keeper/presentation/sign_up/sign_up_view.dart';
import 'package:warranty_keeper/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_keeper/routes/paths.dart';

// USE:
// context.go for navigation
// eg. context.go(Paths.warranty.current.path);

GoRouter appRoutes() => GoRouter(
      routes: [
        GoRoute(
          path: Paths.initial.name,
          redirect: (state) => Paths.login.path,
        ),
        GoRoute(
          path: Paths.login.name,
          builder: (context, state) {
            return const LoginView();
          },
          routes: [
            GoRoute(
              path: Paths.login.signup.name,
              builder: (context, state) {
                return const SignUpView();
              },
            ),
          ],
        ),
        GoRoute(
          path: Paths.home.name,
          builder: (context, state) {
            return const HomeView();
          },
        ),
        // GoRoute(
        //   name: Paths.signup.name,
        //   path: Paths.signup.path,
        //   builder: (context, state) {
        //     return const SignUpView();
        //   },
        // ),
        GoRoute(
          path: Paths.warranty.name,
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: Paths.warranty.newWarranty.name,
              builder: (context, state) {
                return const NewWarrantyView();
              },
            ),
            GoRoute(
              path: Paths.warranty.current.name,
              builder: (context, state) {
                return const CurrentWarrantiesView();
              },
            ),
            GoRoute(
              // /warranties/selected/:selectedId
              path: Paths.warranty.selected.name,
              builder: (context, state) {
                final selectedId =
                    state.params[Paths.warranty.selected.param] as String;
                return const WarrantyDetailsView();
              },
            ),
          ],
        ),
      ],
    );
