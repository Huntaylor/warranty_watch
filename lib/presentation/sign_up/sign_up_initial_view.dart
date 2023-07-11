import 'package:warranty_keeper/modules/cubit/sign_up/sign_up_cubit.dart';
import 'package:warranty_keeper/presentation/login/widgets/get_screen_height.dart';
import 'package:warranty_keeper/presentation/sign_up/step1/sign_up_view.dart';
import 'package:warranty_keeper/presentation/sign_up/step2/personal_data_view.dart';
import 'package:warranty_keeper/presentation/sign_up/step3/tos_sign_up_view.dart';

import '../../../app_library.dart';

class SignUpInitialView extends StatelessWidget {
  const SignUpInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final signUpCubit = context.watch<SignUpCubit>();
          final appBarTitle = switch (signUpCubit.state.asSignUp.signUpStatus) {
            SignUpStatus.signUp => '1',
            SignUpStatus.personalData => '2',
            SignUpStatus.tos => '3',
          };

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (state.asSignUp.signUpStatus == SignUpStatus.signUp) {
                    context.pop();
                  } else {
                    signUpCubit.onSignUpBack();
                  }
                },
              ),
              centerTitle: true,
              title: Text('Step $appBarTitle of 3'),
            ),
            body: _Content(
              signUpCubit: signUpCubit,
            ),
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final SignUpCubit signUpCubit;
  const _Content({
    Key? key,
    required this.signUpCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: getAvailableScreenHeight(context),
          child: switch (signUpCubit.state.asSignUp.signUpStatus) {
            SignUpStatus.signUp => SignUpEmailView(
                signUpCubit: signUpCubit,
              ),
            SignUpStatus.personalData => PersonalDataView(state: signUpCubit.state),
            SignUpStatus.tos => TosSignUpView(
                signUpCubit: signUpCubit,
              ),
          },
        ),
      ),
    );
  }
}
