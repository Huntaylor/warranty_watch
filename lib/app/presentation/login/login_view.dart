import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/login/widgets/animated_box_widget.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';
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
    final authState = context.watch<AuthCubit>().state;

    final l10n = context.l10n;

    final authCubit = context.watch<AuthCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        const animation = Duration(milliseconds: 100);

        return WarrantyBaseView(
          isLoading: authState.isLoading,
          children: [
            const AnimatedBox(
              animation: animation,
            ),
            // const _Logo(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: WarrantyLogo.general(),
            ),
            const AnimatedBox(
              animation: animation,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                l10n.loginCreateTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.apply(
                  color: context.colorScheme.onBackground,
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
              padding:
                  state.isInitial ? const EdgeInsets.only(bottom: 15) : null,
              accountOption: AccountOption.google,
              onPressed: context.read<AuthCubit>().loginWithGoogle,
              isLoading: authCubit.state.isLoading &&
                  authCubit.state.asLoading.loginType == LoginType.google,
              isEnabled: !authCubit.state.isLoading,
            ),
            _SignInFieldSwitch(animation: animation, authCubit: authCubit),
          ],
        );
      },
    );
  }
}

class _SignInFieldSwitch extends StatelessWidget {
  const _SignInFieldSwitch({
    required this.animation,
    required this.authCubit,
  });

  final Duration animation;
  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();
    final state = context.watch<LoginCubit>().state;
    return AnimatedSize(
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
                  authCubit.state.asLoading.loginType == LoginType.email,
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
          WarrantyElevatedButton.loading(
            isLoading: false,
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
            text: l10n.loginButtonText.toUpperCase(),
            isEnabled: !authCubit.state.isLoading,
          ),
          Visibility(
            visible: !state.isInitial,
            child: const _TextButtons(),
          ),
        ],
      ),
    );
  }
}

class _TextButtons extends StatelessWidget {
  const _TextButtons();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child: Text(l10n.createAccount),
          onPressed: () {
            context.read<AuthCubit>().clearError();
            context.push(
              Paths.login.register.path,
            );
          },
        ),
        TextButton(
          child: Text(l10n.forgotPasswordText),
          onPressed: () {
            context.read<AuthCubit>().clearError();
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
    final l10n = context.l10n;
    return Column(
      children: [
        WarrantyTextField.email(
          textFieldName: l10n.loginEmailFieldTitle,
          initialValue: state.asLoggingIn.email,
          onChanged: context.read<LoginCubit>().changeEmail,
          textInputAction: TextInputAction.next,
        ),
        WarrantyTextField.obscured(
          textFieldName: l10n.loginPasswordFieldTitle,
          onObscuredTap: context.read<LoginCubit>().toggleObscurity,
          isObscuredFunction: state.asLoggingIn.isObscured,
          initialValue: state.asLoggingIn.password,
          textInputAction: TextInputAction.done,
          hintText: l10n.passwordHint,
          onFinished: (_) {
            if (!state.isInitial) {
              context.read<AuthCubit>().login(
                    email: state.asLoggingIn.email,
                    password: state.asLoggingIn.password,
                  );
            } else {
              context.read<LoginCubit>().toggleLogin();
            }
          },
          onChanged: context.read<LoginCubit>().changePassword,
        ),
      ],
    );
  }
}
