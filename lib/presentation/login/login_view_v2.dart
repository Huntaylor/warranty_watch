import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/presentation/login/widgets/get_screen_height.dart';

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
          // height: getAvailableScreenHeight(context),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 130,
                  minHeight: 20,
                ),
              ),
              const _Logo(),
              if (authCubit.state.isError)
                RichText(
                  text: TextSpan(
                    text: authCubit.state.asError.message,
                    style: TextStyle(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
              // const _LoginFields(),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 130,
                  minHeight: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Choose One to Create Account',
                  textAlign: TextAlign.center,
                  style:
                      context.textTheme.titleLarge!.apply(fontWeightDelta: 2),
                ),
              ),

              WarrantyElevatedButton.signInOption(
                accountOption: AccountOption.google,
                onPressed: () => context.read<AuthCubit>().loginWithGoogle(),
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
                      authCubit.state.asLoading.loginType == LoginType.apple,
                  isEnabled: !authCubit.state.isLoading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: WarrantyElevatedButton.signInOption(
                  accountOption: AccountOption.email,
                  onPressed: () {},
                  isLoading: authCubit.state.isLoading &&
                      authCubit.state.asLoading.loginType == LoginType.apple,
                  isEnabled: !authCubit.state.isLoading,
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 16,
                endIndent: 16,
                height: 32,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return WarrantyElevatedButton(
                    isLoading: authCubit.state.isLoading &&
                        authCubit.state.asLoading.loginType == LoginType.email,
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
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginFields extends StatelessWidget {
  const _LoginFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return WarrantyTextField.email(
              isRequired: false,
              initialValue: '',
              onChanged: context.read<LoginCubit>().changeEmail,
            );
          },
        ),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return WarrantyTextField.obscured(
              onObscuredTap: () => context.read<LoginCubit>().toggleObscurity(),
              isObscuredFunction: state.asLoggingIn.isObscured,
              isRequired: false,
              initialValue: '',
              hintText: 'Password',
              onChanged: context.read<LoginCubit>().changePassword,
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

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return Align(
      alignment: Alignment.center,
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 24),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
          ),
          child: Text(
            appLocalizations.mainTitle.toUpperCase(),
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
