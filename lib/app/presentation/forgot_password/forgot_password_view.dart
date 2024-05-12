import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_logo_widget.dart';
import 'package:warranty_watch/cubit/auth/auth_cubit.dart';
import 'package:warranty_watch/cubit/forgot_password/forgot_password_cubit.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          if (state.isError) {
            var error = '';
            final forgotPasswordState =
                context.watch<ForgotPasswordCubit>().state;
            if (forgotPasswordState.isError) {
              error = forgotPasswordState.asError.error;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                backgroundColor: context.colorScheme.error,
                content: Text(
                  'There was an issue while attempting to reset your password. $error',
                  style: context.textTheme.bodyMedium,
                ),
              ),
            );
          }
          if (state.isEmailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                backgroundColor: context.colorScheme.primaryContainer,
                content: Text(
                  'Sent! Check your Inbox or Spam to reset your password',
                  style: context.textTheme.bodyMedium,
                ),
              ),
            );
          }
        },
        child: WarrantyBaseView(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'FORGOT PASSWORD',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
          children: [
            const Gap(60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: WarrantyLogo.general(),
            ),
            const Gap(60),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              buildWhen: (_, state) => state.isInitial,
              builder: (context, state) {
                print('State Email ${state.asInitial.email}');
                return WarrantyTextField.email(
                  onChanged: (e) {
                    context.read<ForgotPasswordCubit>().changeEmail(e);
                  },
                  textFieldName: 'Account Email',
                );
              },
            ),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              buildWhen: (_, state) => state.isInitial,
              builder: (context, state) {
                return WarrantyElevatedButton.loading(
                  isLoading: authState.isLoading,
                  isEnabled: state.asInitial.isEnabled,
                  onPressed: () => context
                      .read<AuthCubit>()
                      .submitPasswordReset(state.asInitial.email),
                  text: 'Reset Password',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
