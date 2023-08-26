import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/login/widgets/get_screen_height.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/login/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final authCubit = context.watch<AuthCubit>();

    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            GoRouter.of(context).refresh();
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: getAvailableScreenHeight(context),
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
                      l10n.mainTitle,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (authCubit.state.isError)
                        RichText(
                          text: TextSpan(
                            text: authCubit.state.asError.message,
                            style: TextStyle(
                              color: context.colorScheme.error,
                            ),
                          ),
                        ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return WarrantyTextField.email(
                            isRequired: false,
                            initialValue: '',
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
                                onObscuredTap: () => context
                                    .read<LoginCubit>()
                                    .toggleObscurity(),
                                isObscuredFunction:
                                    state.asLoggingIn.isObscured,
                                isRequired: false,
                                initialValue: '',
                                hintText: 'Password',
                                onChanged: (password) {
                                  context
                                      .read<LoginCubit>()
                                      .changePassword(password);
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
                            isLoading: authCubit.state.isLoading &&
                                authCubit.state.asLoading.loginType ==
                                    LoginType.email,
                            onPressed: () => context.read<AuthCubit>().login(
                                  email: state.asLoggingIn.email,
                                  password: state.asLoggingIn.password,
                                ),
                            text: 'Login',
                            isEnabled: !authCubit.state.isLoading,
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('Sign up'),
                        onPressed: () {
                          context.push(
                            Paths.login.register.path,
                          );
                        },
                      ),
                      WarrantyElevatedButton.signInOption(
                        accountOption: AccountOption.google,
                        onPressed: () =>
                            context.read<AuthCubit>().loginWithGoogle(),
                        isLoading: authCubit.state.isLoading &&
                            authCubit.state.asLoading.loginType ==
                                LoginType.google,
                        isEnabled: !authCubit.state.isLoading,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: WarrantyElevatedButton.signInOption(
                          accountOption: AccountOption.apple,
                          onPressed: () {},
                          isLoading: authCubit.state.isLoading &&
                              authCubit.state.asLoading.loginType ==
                                  LoginType.apple,
                          isEnabled: !authCubit.state.isLoading,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
