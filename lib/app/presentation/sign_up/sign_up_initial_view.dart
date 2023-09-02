import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/sign_up/widgets/password_requirement_widget.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

class SignUpInitialView extends StatelessWidget {
  const SignUpInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Create Account'),
            ),
            body: _Content(state: state),
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.state});
  final SignUpState state;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    String? errorText;

    if (authCubit.state.isError) {
      errorText = 'This email is already in use';
    } else {
      errorText = null;
    }
    final signUpRead = context.read<SignUpCubit>();
    return WarrantyBaseView(
      children: [
        WarrantyTextField.doubleField(
          textFieldName: 'What is your name?',
          hintText: 'First',
          secondHintText: 'Last',
          initialValue: state.asSignUp.firstName ?? '',
          onChanged: context.read<SignUpCubit>().changeFirstName,
          onSecondChanged: context.read<SignUpCubit>().changeLastName,
        ),
        WarrantyTextField.email(
          textFieldName: "What's your email?",
          errorText: errorText,
          initialValue: state.asSignUp.email ?? '',
          onChanged: context.read<SignUpCubit>().changeEmail,
        ),
        WarrantyTextField.obscured(
          textFieldName: 'Create Password',
          hintText: 'Password',
          initialValue: state.asSignUp.password ?? '',
          isObscuredFunction: state.asSignUp.isObscured,
          isRequired: true,
          onChanged: context.read<SignUpCubit>().changePassword,
          onObscuredTap: context.read<SignUpCubit>().toggleObscurity,
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
          textFieldName: 'Confirm Password',
          hintText: 'Re-Enter Password',
          initialValue: state.asSignUp.confirmPassword ?? '',
          isObscuredFunction: state.asSignUp.isConfirmObscured,
          isRequired: true,
          onChanged: context.read<SignUpCubit>().changeConfirmPassword,
          onObscuredTap: context.read<SignUpCubit>().toggleConfirmObscurity,
        ),
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
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: WarrantyElevatedButton.loading(
            onPressed: () async {
              await authCubit.checkEmail(state.asSignUp.email!);
              if (!authCubit.state.isError) {
                signUpRead.pushPersonalData();
              }
            },
            text: 'Next',
            isLoading: authCubit.state.isLoading,
            isEnabled: context.watch<SignUpCubit>().enabledEmailNext(),
          ),
        ),
      ],
    );
  }
}
