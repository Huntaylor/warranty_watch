import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';

class PersonalDataView extends StatelessWidget {
  final SignUpState state;
  const PersonalDataView({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            context.read<SignUpCubit>().pushTos();
          },
          text: 'Next',
          isLoading: false,
          isEnabled: context.read<SignUpCubit>().enabledDataNext(),
        ),
      ],
    );
  }
}
