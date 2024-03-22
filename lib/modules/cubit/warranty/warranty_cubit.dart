import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'warranty_state.dart';
part 'warranty_cubit.g.dart';

class WarrantyCubit extends Cubit<WarrantyState> {
  WarrantyCubit(this._dataRepository)
      : super(
          _Ready(
            warrantyInfo: WarrantyInfo(id: ''),
          ),
        );
  final DataRepository _dataRepository;

  Future<void> toggleLifetime({bool? value}) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          lifetime: value,
        ),
      ),
    );
  }

  Future<void> changePurchaseDate(String date) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          purchaseDate: DateFormat.yMd().parse(date),
        ),
      ),
    );
  }

  Future<void> changeProductName(String productName) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          name: productName,
        ),
      ),
    );
  }

  Future<void> changeWebsiteName(String websiteName) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          warrantyWebsite: websiteName,
        ),
      ),
    );
  }

  Future<void> changeAddtionalDetails(String additionalDetails) async {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          details: additionalDetails,
        ),
      ),
    );
  }

  void changeEndDateChips({required int index}) {
    emit(
      state.asReady.copyWith(
        selectedChip: index,
      ),
    );

    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          lifetime: index == 3 || false,
        ),
      ),
    );

    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          endOfWarranty: addTimeSelected(index),
        ),
      ),
    );
  }

  DateTime addTimeSelected(int index) {
    final endDate = Jiffy.now();

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

  Future<void> changeReminderDate(String date) async {
    final warrantyInfo = state.asReady.warrantyInfo;
    final endOfWarranty = state.asReady.warrantyInfo.endOfWarranty;
    final endOfWarrantyYear = state.asReady.warrantyInfo.endOfWarranty!.year;
    final endOfWarrantyDay = state.asReady.warrantyInfo.endOfWarranty!.day;
    final endOfWarrantyMonth = state.asReady.warrantyInfo.endOfWarranty!.month;

    const twoDayReminder = 2;
    const weekReminder = 7;
    const twoWeeksReminder = 14;
    const monthReminder = 30;

    final daysTill = endOfWarranty!.difference(DateTime.now()).inDays;
    if (warrantyInfo.reminderDate == null) {
      if (daysTill < 7 && daysTill > 1) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                endOfWarrantyYear,
                endOfWarrantyMonth,
                endOfWarrantyDay - twoDayReminder,
              ),
            ),
          ),
        );
      } else if (daysTill < 14 && daysTill > 7) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                endOfWarrantyYear,
                endOfWarrantyMonth,
                endOfWarrantyDay - weekReminder,
              ),
            ),
          ),
        );
      } else if (daysTill < 30 && daysTill > 14) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                endOfWarrantyYear,
                endOfWarrantyMonth,
                endOfWarrantyDay - twoWeeksReminder,
              ),
            ),
          ),
        );
      } else if (daysTill < 90 && daysTill > 30) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                endOfWarrantyYear,
                endOfWarrantyMonth,
                endOfWarrantyDay - monthReminder,
              ),
            ),
          ),
        );
      } else if (daysTill > 90) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                endOfWarrantyYear,
                endOfWarrantyMonth,
                endOfWarrantyDay - monthReminder,
              ),
            ),
          ),
        );
      } else {
        emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateFormat('MM/dd/yyyy').parse(date),
            ),
          ),
        );
      }
    }
  }

  void toggleWantsReminders({required bool value}) {
    emit(
      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          wantsReminders: value,
        ),
      ),
    );
    changeReminderDate('');
  }

  Future<void> changeProductCamera() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              image: imagePicker.path,
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeProductPhotos() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
      if (imagePicker != null) {
        emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              image: imagePicker.path,
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeReceiptCamera() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              receiptImage: imagePicker.path,
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeReceiptPhotos() async {
    try {
      final picker = ImagePicker();
      final imagePicker = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              receiptImage: imagePicker.path,
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> submitWarranty() async {
    if (!state.isReady) {
      return;
    }
    final warrantyDetils = state.asReady.warrantyInfo;
    emit(
      const _Loading(),
    );
    await _dataRepository.submitWarranty(warrantyDetils);
  }

  Future<void> saveDetails() async {
    if (!state.isReady) {
      return;
    }
    final warrantyDetils = state.asReady.warrantyInfo;

    await _dataRepository.submitWarranty(warrantyDetils);
  }

  void editWarrantyInitial(WarrantyInfo editWarrantyInfo) {
    emit(
      state.asReady.copyWith(
        warrantyInfo: editWarrantyInfo,
      ),
    );
  }

  bool verifyWarranty() {
    if (state.isLoading) {
      return false;
    }
    if (state.asReady.warrantyInfo.canSave()) {
      return true;
    } else {
      return false;
    }
  }
}
