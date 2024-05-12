import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.g.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit()
      : super(
          const _Initial(isEnabled: false),
        );

  void changeEmail(String email) {
    emit(
      state.asInitial.copyWith(
        email: email,
      ),
    );
    verifyEmail();
  }

  void verifyEmail() {
    final isEnabled = EmailValidator.validate(state.asInitial.email);

    emit(
      state.asInitial.copyWith(
        isEnabled: isEnabled,
      ),
    );
  }

  bool isValid() => EmailValidator.validate(state.asInitial.email);
}
