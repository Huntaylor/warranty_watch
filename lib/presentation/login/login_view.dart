import 'package:go_router/go_router.dart';

import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/routes/paths.dart';
import 'package:warranty_keeper/widgets/sign_in_options_icons.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

import 'widgets/login_options.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final authCubit = context.read<AuthCubit>();
    final appLocalizations = context.appLocalizations;

    errorSnackBar({required String message}) {
      return SnackBar(
        content: Text(message),
      );
    }

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
                style: context.textTheme.headline4
                    ?.copyWith(color: context.colorScheme.onPrimary),
              ),
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  overscroll: false,
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          // state.map(
                          //   initial: initial,
                          //   loading: loading,
                          //   authenticated: authenticated,
                          //   notAuthenticated: notAuthenticated,
                          //   error: error,
                          //   passwordRequestSubmitted: passwordRequestSubmitted,
                          //   firstRun: firstRun,
                          //   personalDataUpdated: personalDataUpdated,
                          // );
                          state.mapOrNull(
                            error: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                errorSnackBar(message: error.message),
                              );
                            },
                          );
                        },
                        child: const SizedBox(),
                      ),
                      WarrantyTextField.email(
                        isRequired: false,
                        initialValue: '',
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
                            onPressed: () => context.push(Paths.warranty.name),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    state.mapOrNull(
                      authenticated: (value) => context.go(Paths.warranty.name),
                    );
                  },
                  builder: (context, state) {
                    return BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, loginState) {
                        return WarrantyElevatedButton.loading(
                          isLoading:
                              state == const AuthState.loading(isEmail: true),
                          onPressed: () async {
                            await authCubit.login(
                              loginCubit.state.email,
                              loginCubit.state.password,
                            );
                          },
                          text: 'Login',
                          isEnabled: loginCubit.enabledLogin(),
                        );
                      },
                    );
                  },
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () => context.push(Paths.login.signup.name),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Platform.isIOS
                        ? LoginOptions(
                            state: state,
                            widget: WarrantyElevatedButton.iconLoading(
                              onPressed: () async {
                                await authCubit.loginWithApple();
                              },
                              isLoading: state ==
                                  const AuthState.loading(isApple: true),
                              isEnabled: true,
                              widget: const Icon(SignInOptions.apple),
                            ),
                          )
                        : LoginOptions(
                            state: state,
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
