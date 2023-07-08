import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/presentation/sign_up/widgets/password_requirement_widget.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

import '../../../app_library.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Step 1 of 3'),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.watch<SignUpCubit>();
    final authCubit = context.watch<AuthCubit>();
    final state = context.watch<SignUpCubit>().state;

    String? errorText;

    if (authCubit.state.isError) {
      errorText = 'This email is already in use';
    } else {
      errorText = null;
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: getAvailableScreenHeight(context),
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: Column(
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
                    initialValue: '',
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
                    initialValue: '',
                    isObscuredFunction: state.asSignUp.isObscured,
                    isRequired: true,
                    onChanged: context.read<SignUpCubit>().changePassword,
                    onObscuredTap: context.read<SignUpCubit>().toggleObscurity,
                  ),
                  WarrantyTextField.obscured(
                    hintText: 'Confirm Password',
                    initialValue: '',
                    isObscuredFunction: state.asSignUp.isConfirmObscured,
                    isRequired: true,
                    onChanged: context.read<SignUpCubit>().changeConfirmPassword,
                    onObscuredTap: context.read<SignUpCubit>().toggleConfirmObscurity,
                  ),
                ],
              ),
              WarrantyElevatedButton.loading(
                onPressed: () async {
                  await authCubit.checkEmail(state.asSignUp.email!);
                  if (!authCubit.state.isError) {
                    context.push(Paths.login.register.personalData.path);
                  }
                },
                text: 'Next',
                isLoading: authCubit.state.isLoading,
                isEnabled: signUpCubit.enabledEmailNext(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double getAvailableScreenHeight(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
  final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  return screenHeight - statusBarHeight - navigationBarHeight - keyboardHeight;
}
