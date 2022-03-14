import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/home/home_view.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/loginView';
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
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
    final loginCubit = context.read<LoginCubit>();
    final authCubit = context.read<AuthCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              padding: const EdgeInsets.all(8),
              child: const Text('Warranty Tracker'),
            ),
            Column(
              children: [
                WarrantyTextField.general(
                  isRequired: false,
                  initialValue: '',
                  hintText: 'Email',
                  onChanged: loginCubit.changeEmail,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return WarrantyTextField.obscured(
                          onObscuredTap: loginCubit.toggleObscurity,
                          isObscuredFunction: state.isObscured,
                          isRequired: false,
                          initialValue: '',
                          hintText: 'Password',
                          onChanged: loginCubit.changePassword,
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Forgot Password?'),
                      onPressed: () =>
                          navCubit.appNavigator.pushNamed(HomeView.routeName),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return WarrantyElevatedButton.loading(
                      isLoading: state == const AuthLoading(),
                      onPressed: () => authCubit.login(
                        loginCubit.state.email,
                        loginCubit.state.password,
                      ),
                      // navCubit.appNavigator.pushNamed(HomeView.routeName),
                      text: 'Login',
                      isEnabled: loginCubit.enabledLogin(),
                    );
                  },
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () =>
                      navCubit.appNavigator.pushNamed(HomeView.routeName),
                ),
                // BlocBuilder<AuthCubit, AuthState>(
                //   builder: (context, state) {
                //     return WarrantyElevatedButton.iconLoading(
                //       onPressed: () {},
                //       isLoading: state == const AuthLoading(),
                //       isEnabled: true,
                //     );
                //   },
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
