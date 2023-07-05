import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);

  toggleObscurity() {
    emit(!state);
  }
}
