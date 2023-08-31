import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/login/login_cubit.dart';

class LoginViewV2 extends StatelessWidget {
  const LoginViewV2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            GoRouter.of(context).refresh();
          } else if (state.isError) {
            final snackBarError = SnackBar(
              backgroundColor: context.colorScheme.errorContainer,
              content: Text(
                state.asError.message,
                style: context.textTheme.titleSmall,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBarError);
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
    // final l10n = context.l10n;

    final authCubit = context.watch<AuthCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        const animation = Duration(milliseconds: 100);

        return Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const AnimatedBox(
                  animation: animation,
                ),
                const _Logo(),
                const AnimatedBox(
                  animation: animation,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Choose one to Create an Account',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge!.apply(
                      fontWeightDelta: 2,
                    ),
                  ),
                ),
                WarrantyElevatedButton.signInOption(
                  padding: const EdgeInsets.only(bottom: 15),
                  accountOption: AccountOption.apple,
                  onPressed: () {},
                  isLoading: authCubit.state.isLoading &&
                      authCubit.state.asLoading.loginType == LoginType.apple,
                  isEnabled: !authCubit.state.isLoading,
                ),
                WarrantyElevatedButton.signInOption(
                  padding: state.isInitial
                      ? const EdgeInsets.only(bottom: 15)
                      : null,
                  accountOption: AccountOption.google,
                  onPressed: context.read<AuthCubit>().loginWithGoogle,
                  isLoading: authCubit.state.isLoading &&
                      authCubit.state.asLoading.loginType == LoginType.google,
                  isEnabled: !authCubit.state.isLoading,
                ),
                AnimatedSize(
                  duration: animation,
                  child: Column(
                    children: [
                      Visibility(
                        visible: state.isInitial,
                        child: WarrantyElevatedButton.signInOption(
                          accountOption: AccountOption.email,
                          onPressed: () {
                            context.push(
                              Paths.login.register.path,
                            );
                          },
                          isLoading: authCubit.state.isLoading &&
                              authCubit.state.asLoading.loginType ==
                                  LoginType.email,
                          isEnabled: !authCubit.state.isLoading,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        indent: 16,
                        endIndent: 16,
                        height: 30,
                      ),
                      Visibility(
                        visible: !state.isInitial,
                        child: const _LoginFields(),
                      ),
                      WarrantyElevatedButton(
                        isLoading: authCubit.state.isLoading &&
                            authCubit.state.asLoading.loginType ==
                                LoginType.email,
                        onPressed: () {
                          if (!state.isInitial) {
                            context.read<AuthCubit>().login(
                                  email: state.asLoggingIn.email,
                                  password: state.asLoggingIn.password,
                                );
                          } else {
                            context.read<LoginCubit>().toggleLogin();
                          }
                        },
                        text: 'Login',
                        isEnabled: !authCubit.state.isLoading,
                      ),
                      Visibility(
                        visible: !state.isInitial,
                        child: const _TextButtons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedBox extends StatelessWidget {
  const AnimatedBox({
    required this.animation,
    super.key,
  });

  final Duration animation;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    return AnimatedSize(
      duration: animation,
      child: Visibility(
        visible: state.isInitial,
        replacement: const SizedBox(
          height: 70,
        ),
        child: const SizedBox(
          height: 130,
          // height: state.isInitial ? 130 : 75,
        ),
      ),
    );
  }
}

class _TextButtons extends StatelessWidget {
  const _TextButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child: const Text('Create Account'),
          onPressed: () {
            context.push(
              Paths.login.register.path,
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
    );
  }
}

class _LoginFields extends StatelessWidget {
  const _LoginFields();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    return Column(
      children: [
        WarrantyTextField.email(
          textFieldName: 'Account Email',
          isRequired: false,
          initialValue: '',
          onChanged: context.read<LoginCubit>().changeEmail,
        ),
        WarrantyTextField.obscured(
          textFieldName: 'Enter Password',
          onObscuredTap: context.read<LoginCubit>().toggleObscurity,
          isObscuredFunction: state.asLoggingIn.isObscured,
          isRequired: false,
          initialValue: '',
          hintText: 'Password',
          onChanged: context.read<LoginCubit>().changePassword,
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Align(
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 24),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
          ),
          child: Text(
            l10n.mainTitle.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 37.588035583496094,
              height: 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
