import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Step 2 of 3'),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: getAvailableScreenHeight(context),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            'Let\'s add some information about your account',
                          ),
                        ),
                        WarrantyTextField.general(
                          hintText: 'First name',
                          isRequired: true,
                          initialValue: state.asSignUp.firstName ?? '',
                          onChanged: context.read<SignUpCubit>().changeFirstName,
                        ),
                        WarrantyTextField.general(
                          hintText: 'Last name',
                          initialValue: state.asSignUp.lastName ?? '',
                          isRequired: true,
                          onChanged: context.read<SignUpCubit>().changeLastName,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            'You must be 13 years or older to create an account',
                          ),
                        ),
                        WarrantyTextField.dob(
                          initialDateTime: DateTime.now().subtract(
                            const Duration(
                              days: 4748,
                            ),
                          ),
                          hintText: 'Date of birth',
                          initialValue: state.asSignUp.birthday ?? '',
                          isRequired: true,
                          onChanged: context.read<SignUpCubit>().changeDob,
                        ),
                      ],
                    ),
                  ),
                  WarrantyElevatedButton.loading(
                    onPressed: () {
                      context.push(Paths.login.register.tos.path);
                    },
                    text: 'Next',
                    isLoading: false,
                    isEnabled: context.read<SignUpCubit>().enabledDataNext(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
