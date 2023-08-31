import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/models/user_data.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

class TosSignUpView extends StatelessWidget {
  const TosSignUpView({
    required this.signUpCubit,
    super.key,
  });
  final SignUpCubit signUpCubit;
  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.watch<SignUpCubit>();
    final authCubit = context.watch<AuthCubit>();

    const snackBarError = SnackBar(
      content: Text('We were unable to create your account at this time'),
    );
    const snackBar = SnackBar(
      content: Text('Your account has been created'),
    );

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(snackBarError);
        } else if (state.isAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return Checkbox.adaptive(
                    value: state.asSignUp.tosAccepted,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SignUpCubit>().toggleTosAccepted(
                              value: !value,
                            );
                      }
                    },
                  );
                },
              ),
              const Expanded(
                child: Text(
                  'I have and read and accepted the Terms and Conditions above',
                ),
              ),
            ],
          ),
          WarrantyElevatedButton.loading(
            onPressed: () async {
              final userData = UserData.create(
                firstName: signUpCubit.state.asSignUp.firstName!,
                lastName: signUpCubit.state.asSignUp.lastName!,
                email: signUpCubit.state.asSignUp.email!,
                agreedToServices: signUpCubit.state.asSignUp.tosAccepted,
              );
              await authCubit.register(
                signUpCubit.state.asSignUp.email!,
                signUpCubit.state.asSignUp.password!,
                userData,
              );
            },
            text: 'Next',
            isLoading: authCubit.state.isLoading,
            isEnabled: signUpCubit.enabledTosNext(),
          ),
        ],
      ),
    );
  }
}
