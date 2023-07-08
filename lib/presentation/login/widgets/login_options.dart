import '../../../app_library.dart';
import '../../../modules/cubit/auth/auth_cubit.dart';
import '../../../widgets/sign_in_options_icons.dart';

class LoginOptions extends StatelessWidget {
  final Widget? widget;
  final AuthState state;
  const LoginOptions({
    Key? key,
    this.widget,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WarrantyElevatedButton.iconLoading(
          onPressed: () => context.read<AuthCubit>().loginWithGoogle(),
          isLoading: state.isLoading,
          isEnabled: true,
          widget: const Icon(SignInOptions.google),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 3.0),
        //   child: WarrantyElevatedButton.iconLoading(
        //     onPressed: () {},
        //     isLoading: state == const AuthState.loading(isFacebook: true),
        //     isEnabled: true,
        //     widget: const Icon(SignInOptions.facebook),
        //   ),
        // ),
        if (widget != null) widget!
      ],
    );
  }
}
