import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/presentation/sign_up/widgets/password_requirement_widget.dart';

class SignUpEmailView extends StatelessWidget {
  final SignUpCubit signUpCubit;
  const SignUpEmailView({
    required this.signUpCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = signUpCubit.state;
    final authCubit = context.watch<AuthCubit>();

    String? errorText;

    if (authCubit.state.isError) {
      errorText = 'This email is already in use';
    } else {
      errorText = null;
    }
    final signUpRead = context.read<SignUpCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Enter your email, we will have you confirm it after registering',
              ),
            ),
            WarrantyTextField.email(
              errorText: errorText,
              isRequired: true,
              initialValue: state.asSignUp.email ?? '',
              onChanged: context.read<SignUpCubit>().changeEmail,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 8),
                    child: Text('Your Password must contain:'),
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasSixCharacters,
                    title: '6 characters or more',
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasLowerUpperCase,
                    title: 'A lower and upper case letter',
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasNumber,
                    title: 'A number',
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasSpecialCharacter,
                    title: 'A special character',
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.isMatching,
                    title: 'Passwords must match',
                  ),
                ],
              ),
            ),
            WarrantyTextField.obscured(
              hintText: 'Password',
              initialValue: state.asSignUp.password ?? '',
              isObscuredFunction: state.asSignUp.isObscured,
              isRequired: true,
              onChanged: context.read<SignUpCubit>().changePassword,
              onObscuredTap: context.read<SignUpCubit>().toggleObscurity,
            ),
            WarrantyTextField.obscured(
              hintText: 'Confirm Password',
              initialValue: state.asSignUp.confirmPassword ?? '',
              isObscuredFunction: state.asSignUp.isConfirmObscured,
              isRequired: true,
              onChanged: context.read<SignUpCubit>().changeConfirmPassword,
              onObscuredTap: context.read<SignUpCubit>().toggleConfirmObscurity,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: WarrantyElevatedButton.loading(
            onPressed: () async {
              await authCubit.checkEmail(state.asSignUp.email!);
              if (!authCubit.state.isError) {
                signUpRead.pushPersonalData();
              }
            },
            text: 'Next',
            isLoading: authCubit.state.isLoading,
            isEnabled: signUpCubit.enabledEmailNext(),
          ),
        ),
      ],
    );
  }
}
