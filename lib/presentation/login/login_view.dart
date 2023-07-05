import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/login/login_cubit.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue,
              child: const Text('Warranty Tracker'),
            ),
            Column(
              children: [
                WarrantyTextField.general(
                  isRequired: false,
                  initialValue: '',
                  hintText: 'Email',
                  onChanged: (_) {},
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<LoginCubit, bool>(
                      builder: (context, isObscured) {
                        return WarrantyTextField.obscured(
                          onObscuredTap: () => context.read<LoginCubit>().toggleObscurity(),
                          isObscuredFunction: isObscured,
                          isRequired: false,
                          initialValue: '',
                          hintText: 'Password',
                          onChanged: (_) {},
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Forgot Password?'),
                      onPressed: () {
                        context.push(Paths.login.forgotPassword.path);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                WarrantyElevatedButton(
                  onPressed: () => context.read<AuthCubit>().login('', ''),
                  text: 'Login',
                  isEnabled: true,
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () => context.read<AuthCubit>().register('', ''),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
