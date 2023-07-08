import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/widgets/warranty_textfield.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          maintainBottomViewPadding: false,
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
                          'Let\'s add some information about your account',
                        ),
                      ),
                      WarrantyTextField.general(
                        hintText: 'First name',
                        isRequired: true,
                        initialValue: '',
                        onChanged: context.read<SignUpCubit>().changeFirstName,
                      ),
                      WarrantyTextField.general(
                        hintText: 'Last name',
                        initialValue: '',
                        isRequired: true,
                        onChanged: context.read<SignUpCubit>().changeLastName,
                      ),
                      WarrantyTextField.dob(
                        initialDateTime: DateTime.now(),
                        hintText: 'Date of birth',
                        initialValue: '',
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
        );
      },
    );
  }
}
