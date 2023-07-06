import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState.initial());

  toggleNotifications(bool value) {
    emit(
      state.copyWith(
        isNotifications: value,
      ),
    );
  }

  toggleSomething(bool value) {
    //TODO add function
    emit(
      state.copyWith(
        isSomething: value,
      ),
    );
  }
}
