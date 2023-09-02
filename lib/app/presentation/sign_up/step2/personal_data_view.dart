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
        const Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Let's add some information",
                ),
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
