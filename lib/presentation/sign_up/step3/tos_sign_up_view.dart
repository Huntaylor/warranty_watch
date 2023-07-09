import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/auth/auth_cubit.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';

class TosSignUpView extends StatelessWidget {
  const TosSignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Step 3 of 3'),
      ),
      body: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
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

    return SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: getAvailableScreenHeight(context),
          child: Column(
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
                      signUpCubit.state.asSignUp.birthday!,
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
