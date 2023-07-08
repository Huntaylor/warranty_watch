import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class LoginView extends StatelessWidget {
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
    final appLocalizations = context.appLocalizations;

    final authCubit = context.watch<AuthCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colorScheme.primary,
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                appLocalizations.mainTitle,
                style: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.onPrimary),
              ),
            ),
            Column(
              children: [
                if (authCubit.state.isError)
                  const SizedBox(
                    child: Text('We were unable to log you in at this time'),
                    height: 25,
                  ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return WarrantyTextField.general(
                      isRequired: false,
                      initialValue: '',
                      hintText: 'Email',
                      onChanged: (email) {
                        context.read<LoginCubit>().changeEmail(email);
                      },
                    );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return WarrantyTextField.obscured(
                          onObscuredTap: () => context.read<LoginCubit>().toggleObscurity(),
                          isObscuredFunction: state.asLoggingIn.isObscured,
                          isRequired: false,
                          initialValue: '',
                          hintText: 'Password',
                          onChanged: (password) {
                            context.read<LoginCubit>().changePassword(password);
                          },
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Forgot Password?'),
                      onPressed: () {
                        context.push(Paths.login.forgotPassword.path);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return WarrantyElevatedButton(
                      isLoading: context.read<AuthCubit>().state.isLoading,
                      onPressed: () => context.read<AuthCubit>().login(
                            email: state.asLoggingIn.email,
                            password: state.asLoggingIn.password,
                          ),
                      text: 'Login',
                      isEnabled: true,
                    );
                  },
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    context.read<AuthCubit>().setInitial();
                    context.push(
                      Paths.login.register.path,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
