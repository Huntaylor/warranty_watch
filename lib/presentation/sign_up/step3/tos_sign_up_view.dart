import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';

class TosSignUpView extends StatelessWidget {
  final SignUpCubit signUpCubit;
  const TosSignUpView({
    Key? key,
    required this.signUpCubit,
  }) : super(key: key);
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'I have and read and accepted the Terms and Conditions above',
              ),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return Checkbox.adaptive(
                    value: state.asSignUp.tosAccepted,
                    onChanged: (value) {
                      context.read<SignUpCubit>().toggleTosAccepted(value!);
                    });
              },
            ),
          ],
        ),
        WarrantyElevatedButton.loading(
          onPressed: () async {
            await authCubit
                .register(
              signUpCubit.state.asSignUp.email!,
              signUpCubit.state.asSignUp.password!,
            )
                .whenComplete(() async {
              await authCubit.updatePersonalData(
                signUpCubit.state.asSignUp.firstName!,
                signUpCubit.state.asSignUp.lastName!,
              );
              if (authCubit.state.isError) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarError);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
          text: 'Next',
          isLoading: authCubit.state.isLoading,
          isEnabled: signUpCubit.enabledTosNext(),
        ),
      ],
    );
  }
}
