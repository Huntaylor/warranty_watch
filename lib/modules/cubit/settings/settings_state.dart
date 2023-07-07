part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  _Initial get asInitial => this as _Initial;
  _SetSettings get asSet => this as _SetSettings;

  @override
  List<Object?> get props => [];
}

class _Initial extends SettingsState {
  const _Initial();
}

@autoequal
class _SetSettings extends SettingsState {
  const _SetSettings({this.isNotifications, this.isSomething});
  final bool? isNotifications;
  final bool? isSomething;

  @override
  List<Object?> get props => _$props;
}
