import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({
    required this.state,
    super.key,
  });
  final SignUpState state;

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
                  "Let's add some information",
                ),
              ),
              Row(
                children: [
                  const Text(
                    'What is your name?',
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
                ],
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
