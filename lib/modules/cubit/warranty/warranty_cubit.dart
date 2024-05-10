// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:app_settings/app_settings_platform_interface.dart';
import 'package:autoequal/autoequal.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'warranty_state.dart';
part 'warranty_cubit.g.dart';

enum WarrantyType {
  newWarr,
  existingWarr,
}

enum FileTarget {
  receipt,
  product,
}

class WarrantyCubit extends Cubit<WarrantyState> {
  WarrantyCubit(this._dataRepository, {this.warrantyInfo})
      : super(
          _Ready(
            warrantyInfo: warrantyInfo ?? const WarrantyInfo(id: ''),
          ),
        ) {
    AppLifecycleListener(
      onResume: checkSystemSettings,
    );
    checkSystemSettings();
  }

  final DataRepository _dataRepository;
  final WarrantyInfo? warrantyInfo;

  Future<void> toggleLifetime({bool? value}) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          lifetime: value,
        ),
      ),
    );
    _verifyWarranty();
  }

  Future<void> changeProductName(String productName) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          name: productName,
        ),
      ),
    );
    _verifyWarranty();
  }

  Future<void> changeWebsiteName(String websiteName) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          warrantyWebsite: websiteName,
        ),
      ),
    );
    _verifyWarranty();
  }

  Future<void> changeAddtionalDetails(String additionalDetails) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          details: additionalDetails,
        ),
      ),
    );
    _verifyWarranty();
  }

  Future<void> checkNotifications() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            wantsReminders: isAllowed,
          ),
        ),
      );
    });
  }

  Future<void> toggleNotifications() async {
    await AppSettingsPlatform.instance
        .openAppSettings(type: AppSettingsType.notification);
  }

  Future<void> createNotifications() async {
    final estimatedTime =
        Jiffy.parseFromDateTime(state.asReady.warrantyInfo.endOfWarranty!)
            .fromNow();

    await AwesomeNotifications().createNotification(
      schedule: NotificationAndroidCrontab.fromDate(
        allowWhileIdle: true,
        date: state.asReady.warrantyInfo.reminderDate!.add(
          const Duration(
            hours: 8,
          ),
        ),
      ),
      content: NotificationContent(
        notificationLayout: NotificationLayout.BigText,
        id: state.asReady.warrantyInfo.name.hashCode,
        channelKey: 'reminder_channel',
        category: NotificationCategory.Reminder,
        actionType: ActionType.Default,
        title: 'Warranty Reminder',
        body:
            'Your warranty, ${state.asReady.warrantyInfo.name}, expires $estimatedTime!',
      ),
    );
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar.fromDate(
        allowWhileIdle: true,
        date: state.asReady.warrantyInfo.endOfWarranty!,
      ),
      content: NotificationContent(
        notificationLayout: NotificationLayout.BigText,
        id: state.asReady.warrantyInfo.name.hashCode,
        channelKey: 'expired_channel',
        category: NotificationCategory.Reminder,
        actionType: ActionType.Default,
        title: 'Warranty Expired',
        body: 'Your warranty, ${state.asReady.warrantyInfo.name}, has expired!',
      ),
    );
  }

  Future<void> changeEndOfWarrantyDate(DateTime date) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          endOfWarranty: date,
          lifetime: false,
        ),
        selectedWarrantyDateChip: null,
      ),
    );
    _verifyWarranty();
  }

  Future<void> changePurchaseDate(DateTime date) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          purchaseDate: date,
        ),
      ),
    );
    _verifyWarranty();
  }

  Future<void> changeEndDateChips({required int index}) async {
    if (state.asReady.warrantyInfo.wantsReminders) {
      await checkNotifications();
    }
    emit(
      state.asReady.copyWith(
        selectedWarrantyDateChip: index,
      ),
    );
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          lifetime: index == 3 || false,
        ),
      ),
    );
    if (index != 3) {
      emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            endOfWarranty: addTimeSelected(index),
          ),
        ),
      );
    }
    if (index == 3 && state.asReady.warrantyInfo.endOfWarranty != null) {
      emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            endOfWarranty: null,
            reminderDate: null,
          ),
        ),
      );
      emit(
        state.asReady.copyWith(
          selectedReminderDateChip: null,
        ),
      );
    }
    _verifyWarranty();
  }

  Future<void> changeReminderChips({required int index}) async {
    await checkNotifications();

    final warrantyInfo = state.asReady.warrantyInfo;
    final endOfWarranty = warrantyInfo.endOfWarranty;
    final endOfWarrantyYear = endOfWarranty!.year;
    final endOfWarrantyDay = endOfWarranty.day;
    final endOfWarrantyMonth = endOfWarranty.month;

    const twoDayReminder = 1;
    const weekReminder = 7;
    const twoWeeksReminder = 14;
    const monthReminder = 30;

    var selectedDate = DateTime.now();

    emit(
      state.asReady.copyWith(
        selectedReminderDateChip: index,
      ),
    );

    switch (index) {
      case 0:
        selectedDate = DateTime(
          endOfWarrantyYear,
          endOfWarrantyMonth,
          endOfWarrantyDay - twoDayReminder,
        );

      case 1:
        selectedDate = DateTime(
          endOfWarrantyYear,
          endOfWarrantyMonth,
          endOfWarrantyDay - weekReminder,
        );

      case 2:
        selectedDate = DateTime(
          endOfWarrantyYear,
          endOfWarrantyMonth,
          endOfWarrantyDay - twoWeeksReminder,
        );

      case 3:
        selectedDate = DateTime(
          endOfWarrantyYear,
          endOfWarrantyMonth,
          endOfWarrantyDay - monthReminder,
        );
    }
    await changeReminderDate(
      selectedDate,
      withChips: true,
    );
    _verifyWarranty();
  }

  DateTime addTimeSelected(int index) {
    final now = DateTime.now();
    final endDate = Jiffy.parseFromDateTime(
      DateTime(
        now.year,
        now.month,
        now.day,
      ),
    );

    switch (index) {
      case 0:
        return endDate.add(days: 30).dateTime;
      case 1:
        return endDate.add(years: 1).dateTime;
      case 2:
        return endDate.add(years: 5).dateTime;
      default:
        return endDate.dateTime;
    }
  }

  Future<void> changeReminderDate(
    DateTime date, {
    required bool withChips,
  }) async {
    await checkNotifications();

    final warrantyInfo = state.asReady.warrantyInfo;
    if (!withChips) {
      emit(
        state.asReady.copyWith(
          selectedReminderDateChip: null,
        ),
      );
    }

    emit(
      state.asReady.copyWith(
        warrantyInfo: warrantyInfo.copyWith(
          reminderDate: date,
        ),
      ),
    );
    _verifyWarranty();
  }

  void toggleWantsReminders({required bool value}) {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          wantsReminders: value,
        ),
      ),
    );
    if (!value) {
      emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            reminderDate: null,
          ),
        ),
      );
    }
    _verifyWarranty();
  }

  Future<void> changeImage({required FileTarget fileTarget}) async {
    try {
      final picker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (picker != null) {
        emit(
          switch (fileTarget) {
            FileTarget.receipt => state.asReady.copyWith(
                warrantyInfo: state.asReady.warrantyInfo.copyWith(
                  receiptImage: picker.path,
                ),
              ),
            FileTarget.product => state.asReady.copyWith(
                warrantyInfo: state.asReady.warrantyInfo.copyWith(
                  image: picker.path,
                ),
              ),
          },
        );
      }
      emit(
        state.asReady.copyWith(hasError: false),
      );
    } catch (e) {
      emit(
        state.asReady.copyWith(hasError: true),
      );
    }
    _verifyWarranty();
  }

  Future<void> changeFile({required FileTarget fileTarget}) async {
    try {
      final picker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (picker != null) {
        emit(
          switch (fileTarget) {
            FileTarget.receipt => state.asReady.copyWith(
                warrantyInfo: state.asReady.warrantyInfo.copyWith(
                  receiptImage: picker.path,
                ),
              ),
            FileTarget.product => state.asReady.copyWith(
                warrantyInfo: state.asReady.warrantyInfo.copyWith(
                  image: picker.path,
                ),
              ),
          },
        );
      }
      emit(
        state.asReady.copyWith(hasError: false),
      );
    } catch (e) {
      emit(
        state.asReady.copyWith(hasError: true),
      );
    }
    _verifyWarranty();
  }

  Future<void> submitWarranty() async {
    if (!state.isReady) {
      return;
    }
    final warrantyDetils = state.asReady.warrantyInfo;
    emit(
      state.asReady.copyWith(
        isLoading: true,
        hasError: false,
      ),
    );
    final data = _dataRepository.submitWarranty(warrantyDetils);

    await data.then(
      (value) async {
        if (warrantyDetils.wantsReminders) {
          await createNotifications();
        }
        emit(
          const _Success(),
        );
      },
      onError: (e) => emit(
        state.asReady.copyWith(
          firebaseError: true,
          isLoading: false,
        ),
      ),
    );
  }

  void closeError() => emit(
        state.asReady.copyWith(
          firebaseError: false,
          hasError: false,
        ),
      );

  void editWarrantyInitial(WarrantyInfo editWarrantyInfo) => emit(
        state.asReady.copyWith(
          warrantyInfo: editWarrantyInfo,
        ),
      );

  void _verifyWarranty() {
    if (state.asReady.isLoading ?? false) {
      emit(
        state.asReady.copyWith(
          canSubmit: false,
        ),
      );
    }
    emit(
      state.asReady.copyWith(
        canSubmit: state.asReady.warrantyInfo.canSubmit(),
      ),
    );
  }

  void clearEndOfWarrantyDate() {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          endOfWarranty: null,
          lifetime: false,
        ),
        selectedWarrantyDateChip: null,
      ),
    );

    _verifyWarranty();
  }

  void clearReminderDate() {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          reminderDate: null,
        ),
        selectedReminderDateChip: null,
      ),
    );
    _verifyWarranty();
  }

  void clearPurchaseDate() {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          purchaseDate: null,
        ),
      ),
    );
    _verifyWarranty();
  }

  void removeRecieptImage() => emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            receiptImage: null,
          ),
        ),
      );

  void removeProductImage() => emit(
        state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            image: null,
          ),
        ),
      );

  Future<void> checkSystemSettings() async {
    final isEnabled = await AwesomeNotifications().isNotificationAllowed();
    emit(
      state.asReady.copyWith(isNotificationEnabled: isEnabled),
    );
  }
}
