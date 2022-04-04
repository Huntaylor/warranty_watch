import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
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
                  const Text(
                    'Enter your email, we will have your confirm it after your register',
                  ),
                  WarrantyTextField.email(
                    isRequired: true,
                    initialValue: '',
                    onChanged: context.read<SignUpCubit>().changeEmail,
                  ),
                  const Text(
                    'Password must be 6 Characters or more',
                  ),
                  const Text(
                    'Password must contain a special character',
                  ),
                  const Text(
                    'Password must contain a lower and upper case letter',
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return WarrantyTextField.obscured(
                        hintText: 'Password',
                        initialValue: '',
                        isObscuredFunction: state.isObscured,
                        isRequired: true,
                        onChanged: context.read<SignUpCubit>().changePassword,
                        onObscuredTap:
                            context.read<SignUpCubit>().toggleObscurity,
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('Passwords must match'),
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return WarrantyTextField.obscured(
                        hintText: 'Confirm Password',
                        initialValue: '',
                        isObscuredFunction: state.isConfirmObscured,
                        isRequired: true,
                        onChanged:
                            context.read<SignUpCubit>().changeConfirmPassword,
                        onObscuredTap:
                            context.read<SignUpCubit>().toggleConfirmObscurity,
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
