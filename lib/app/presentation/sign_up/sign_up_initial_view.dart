import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/login/widgets/get_screen_height.dart';
import 'package:warranty_watch/app/presentation/sign_up/step1/sign_up_view.dart';
import 'package:warranty_watch/app/presentation/sign_up/step2/personal_data_view.dart';
import 'package:warranty_watch/app/presentation/sign_up/step3/tos_sign_up_view.dart';
import 'package:warranty_watch/modules/cubit/sign_up/sign_up_cubit.dart';

class SignUpInitialView extends StatelessWidget {
  const SignUpInitialView({super.key});

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
  const _Content({
    required this.signUpCubit,
  });
  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: getAvailableScreenHeight(context),
          child: switch (signUpCubit.state.asSignUp.signUpStatus) {
            SignUpStatus.signUp => SignUpEmailView(
                signUpCubit: signUpCubit,
              ),
            SignUpStatus.personalData =>
              PersonalDataView(state: signUpCubit.state),
            SignUpStatus.tos => TosSignUpView(
                signUpCubit: signUpCubit,
              ),
          },
        ),
      ),
    );
  }
}
