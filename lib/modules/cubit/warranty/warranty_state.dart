// ignore_for_file: library_private_types_in_public_api

part of 'warranty_cubit.dart';

abstract class WarrantyState extends Equatable {
  const WarrantyState();

  bool get isError => this is _Error;
  bool get isSuccessful => this is _Success;
  bool get isReady => this is _Ready;

  _Error get asError => this as _Error;
  _Success get asSuccess => this as _Success;
  _Ready get asReady => this as _Ready;

  @override
  List<Object?> get props => [];
}

class _Error extends WarrantyState {
  const _Error();
}

class _Success extends WarrantyState {
  const _Success();
}

@autoequal
@CopyWith()
class _Ready extends WarrantyState {
  const _Ready({
    required this.warrantyInfo,
    this.selectedReminderDateChip,
    this.selectedWarrantyDateChip,
    this.hasError,
    this.firebaseError,
    this.isLoading,
    this.canSubmit,
    this.isNotificationEnabled = false,
    this.askedNotification = false,
  });
  final WarrantyInfo warrantyInfo;
  final int? selectedWarrantyDateChip;
  final int? selectedReminderDateChip;
  final bool? hasError;
  final bool? firebaseError;
  final bool? isLoading;
  final bool? canSubmit;
  final bool isNotificationEnabled;
  final bool askedNotification;

  List<Map<String, String>> get warrantyDurationChips {
    const list = [
      {
        'duration': '30 Days',
      },
      {
        'duration': '1 Year',
      },
      {
        'duration': '5 Years',
      },
      {
        'duration': 'Lifetime',
      },
    ];
    return list;
  }

  List<Map<String, String>> get reminderChips {
    const list = [
      {
        'duration': '1 Day',
      },
      {
        'duration': '1 Week',
      },
      {
        'duration': '2 Weeks',
      },
      {
        'duration': '30 Days',
      },
    ];
    return list;
  }

  @override
  List<Object?> get props => _$props;
}
