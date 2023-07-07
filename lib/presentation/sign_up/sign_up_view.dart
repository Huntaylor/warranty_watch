import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/presentation/sign_up/widgets/password_requirement_widget.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

import '../../app_library.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Step 1 of 3'),
      ),
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Enter your email, we will have your confirm it after you register',
                    ),
                  ),
                  WarrantyTextField.email(
                    isRequired: true,
                    initialValue: '',
                    onChanged: context.read<SignUpCubit>().changeEmail,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
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
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return WarrantyTextField.obscured(
                        hintText: 'Password',
                        initialValue: '',
                        isObscuredFunction: state.asSignUp.isObscured,
                        isRequired: true,
                        onChanged: context.read<SignUpCubit>().changePassword,
                        onObscuredTap: context.read<SignUpCubit>().toggleObscurity,
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return WarrantyTextField.obscured(
                        hintText: 'Confirm Password',
                        initialValue: '',
                        isObscuredFunction: state.asSignUp.isConfirmObscured,
                        isRequired: true,
                        onChanged: context.read<SignUpCubit>().changeConfirmPassword,
                        onObscuredTap: context.read<SignUpCubit>().toggleConfirmObscurity,
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return WarrantyElevatedButton.loading(
                  onPressed: () {},
                  text: 'Next',
                  isLoading: false,
                  isEnabled: context.read<SignUpCubit>().enabledNext(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
