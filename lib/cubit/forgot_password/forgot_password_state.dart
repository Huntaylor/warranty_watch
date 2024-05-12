// ignore_for_file: library_private_types_in_public_api

part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  bool get isInitial => this is _Initial;
  bool get isError => this is _Error;

  _Initial get asInitial => this as _Initial;
  _Error get asError => this as _Error;

  @override
  List<Object?> get props => [];
}

@CopyWith()
@autoequal
class _Initial extends ForgotPasswordState {
  const _Initial({
    required this.isEnabled,
    this.email = '',
  });
  final String email;
  final bool isEnabled;

  @override
  List<Object?> get props => _$props;
}

@CopyWith()
@autoequal
class _Error extends ForgotPasswordState {
  const _Error({
    required this.error,
  });
  final String error;
  @override
  List<Object?> get props => _$props;
}
