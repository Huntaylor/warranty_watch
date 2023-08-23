import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/presentation/login/widgets/get_screen_height.dart';
import 'package:warranty_keeper/widgets/sign_in_options_icons.dart';

class LoginViewV2 extends StatelessWidget {
  const LoginViewV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            GoRouter.of(context).refresh();
          }
        },
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content() : super();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    final authCubit = context.watch<AuthCubit>();
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          height: getAvailableScreenHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(360, 180),
                  ),
                ),
                child: Text(
                  appLocalizations.mainTitle,
                  style: TextStyle(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    height: 60 / 37.588035583496094,
                    fontSize: 37.588035583496094,
                  ),
                  textAlign: TextAlign.center,
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
                            onObscuredTap: () =>
                                context.read<LoginCubit>().toggleObscurity(),
                            isObscuredFunction: state.asLoggingIn.isObscured,
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
                      context.read<AuthCubit>().setInitial();
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
                        authCubit.state.asLoading.loginType == LoginType.google,
                    isEnabled: !authCubit.state.isLoading,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: WarrantyElevatedButton.signInOption(
                      accountOption: AccountOption.apple,
                      onPressed: () {},
                      isLoading: authCubit.state.isLoading &&
                          authCubit.state.asLoading.loginType ==
                              LoginType.apple,
                      isEnabled: !authCubit.state.isLoading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: WarrantyElevatedButton.signInOption(
                      accountOption: AccountOption.email,
                      onPressed: () {},
                      isLoading: authCubit.state.isLoading &&
                          authCubit.state.asLoading.loginType ==
                              LoginType.apple,
                      isEnabled: !authCubit.state.isLoading,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
