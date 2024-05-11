// ignore_for_file: library_private_types_in_public_api

part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  bool get isSetSettings => this is _SetSettings;

  _SetSettings get asSet => this as _SetSettings;

  @override
  List<Object?> get props => [];
}

@autoequal
@CopyWith()
class _SetSettings extends SettingsState {
  const _SetSettings({
    required this.isNotificationAllowed,
    required this.isSomething,
    this.isNotificationEnabled = false,
  });

  final bool isNotificationAllowed;
  final bool isNotificationEnabled;
  final bool isSomething;

  @override
  List<Object?> get props => _$props;
}
