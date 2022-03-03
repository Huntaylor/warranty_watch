import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/loginView';
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Warranty Tracker'),
            Column(
              children: [
                WarrantyElevatedButton(
                  onPressed: () =>
                      navCubit.appNavigator.pushNamed(HomeView.routeName),
                  text: 'Login',
                  isEnabled: true,
                ),
                WarrantyElevatedButton(
                  onPressed: () =>
                      navCubit.appNavigator.pushNamed(HomeView.routeName),
                  text: 'Sign Up',
                  isEnabled: true,
                ),
                WarrantyElevatedButton(
                  onPressed: () =>
                      navCubit.appNavigator.pushNamed(HomeView.routeName),
                  text: 'Forgot Password',
                  isEnabled: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
