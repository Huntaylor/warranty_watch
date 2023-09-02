import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/models/user_data.dart';
import 'package:warranty_watch/app/presentation/sign_up/widgets/password_requirement_widget.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            l10n.createAccount.toUpperCase(),
          ),
        ),
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();

    String? errorText;

    if (authCubit.state.isError) {
      errorText = l10n.emailError;
    } else {
      errorText = null;
    }
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return WarrantyBaseView(
          children: [
            const SizedBox(
              height: 15,
            ),
            WarrantyTextField.doubleField(
              textFieldName: l10n.nameFieldTitle,
              hintText: l10n.first,
              secondHintText: l10n.last,
              initialValue: state.asSignUp.firstName ?? '',
              onChanged: context.read<SignUpCubit>().changeFirstName,
              onSecondChanged: context.read<SignUpCubit>().changeLastName,
            ),
            WarrantyTextField.email(
              textFieldName: l10n.emailFieldTitle,
              errorText: errorText,
              initialValue: state.asSignUp.email ?? '',
              onChanged: context.read<SignUpCubit>().changeEmail,
            ),
            WarrantyTextField.obscured(
              textFieldName: l10n.passwordFieldTitle,
              hintText: l10n.passwordHint,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(l10n.passwordRuleTitle),
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasSixCharacters,
                    title: l10n.passwordRule1,
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasLowerUpperCase,
                    title: l10n.passwordRule2,
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasNumber,
                    title: l10n.passwordRule3,
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.hasSpecialCharacter,
                    title: l10n.passwordRule4,
                  ),
                  PasswordRequirementWidget(
                    isTrue: state.asSignUp.isMatching,
                    title: l10n.passwordRule5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            WarrantyTextField.obscured(
              textFieldName: l10n.confirmPasswordFieldTitle,
              hintText: l10n.confirmPasswordHint,
              initialValue: state.asSignUp.confirmPassword ?? '',
              isObscuredFunction: state.asSignUp.isConfirmObscured,
              isRequired: true,
              onChanged: context.read<SignUpCubit>().changeConfirmPassword,
              onObscuredTap: context.read<SignUpCubit>().toggleConfirmObscurity,
            ),
            Text(
              l10n.tosTitle + l10n.tosTitleContinue,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Checkbox.adaptive(
                  value: state.asSignUp.tosAccepted,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SignUpCubit>().toggleTosAccepted(
                            value: value,
                          );
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    l10n.tosAcceptanceText,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: WarrantyElevatedButton.loading(
                onPressed: () async {
                  await authCubit.checkEmail(state.asSignUp.email!);
                  if (authCubit.state.isError) {
                    return;
                  }
                  final userData = UserData.create(
                    firstName: state.asSignUp.firstName!,
                    lastName: state.asSignUp.lastName!,
                    email: state.asSignUp.email!,
                    agreedToServices: state.asSignUp.tosAccepted,
                  );
                  await authCubit.register(
                    state.asSignUp.email!,
                    state.asSignUp.password!,
                    userData,
                  );
                },
                text: l10n.createAccount.toUpperCase(),
                isLoading: authCubit.state.isLoading,
                isEnabled: context.watch<SignUpCubit>().enabledRegister(),
              ),
            ),
          ],
        );
      },
    );
  }
}
