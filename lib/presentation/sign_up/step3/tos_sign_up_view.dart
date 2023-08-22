import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/models/user_data.dart';
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
    //TODO: REFACTOR
    final scaffold = ScaffoldMessenger.of(context);

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

            if (authCubit.state.isError) {
              //TODO: REFACTOR
              scaffold.showSnackBar(snackBarError);
            } else {
              scaffold.showSnackBar(snackBar);
            }
          },
          text: 'Next',
          isLoading: authCubit.state.isLoading,
          isEnabled: signUpCubit.enabledTosNext(),
        ),
      ],
    );
  }
}
