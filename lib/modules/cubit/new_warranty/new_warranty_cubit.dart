import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class NewWarrantyCubit extends Cubit<WarrantyInfo> {
  //TODO: RENAME TO WARRANTYCUBIT, IT WILL HANDLE CURRENT, SINGULAR, WARRANTIY TO UPDATE, CREATE, AND DELETE ONE
  final WarrantyRepository _warrantyRepository;
  NewWarrantyCubit(this._warrantyRepository) : super(const WarrantyInfo(warrantyId: ''));

  toggleLifeTime() {
    emit(
      state.copyWith(
        lifeTime: !state.lifeTime,
      ),
    );
  }

  changePurchaseDate(String date) {
    emit(
      state.copyWith(
        purchaseDate: DateFormat.yMd().parse(date),
      ),
    );
  }

  changeProductName(String productName) {
    emit(
      state.copyWith(
        name: productName,
      ),
    );
  }

  changeWebsiteName(String websiteName) {
    emit(
      state.copyWith(
        warrantyWebsite: websiteName,
      ),
    );
  }

  changeAddtionalDetails(String additionalDetails) {
    emit(
      state.copyWith(
        details: additionalDetails,
      ),
    );
  }

  changeEndDate(String date) {
    emit(
      state.copyWith(
        endOfWarranty: DateFormat('MM/dd/yyyy').parse(date),
      ),
    );
    changeReminderDate(date);
  }

  changeReminderDate(String date) {
    final daysTill = state.endOfWarranty!.difference(DateTime.now()).inDays;
    if (state.reminderDate == null) {
      if (daysTill < 7 && daysTill > 1) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 2,
            ),
          ),
        );
      } else if (daysTill < 14 && daysTill > 7) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 7,
            ),
          ),
        );
      } else if (daysTill < 30 && daysTill > 14) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 14,
            ),
          ),
        );
      } else if (daysTill < 90 && daysTill > 30) {
        return emit(
          state.copyWith(
              reminderDate: DateTime(
            state.endOfWarranty!.year,
            state.endOfWarranty!.month,
            state.endOfWarranty!.day - 30,
          )),
        );
      } else if (daysTill > 90) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 30,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            reminderDate: DateFormat('MM/dd/yyyy').parse(date),
          ),
        );
      }
    }
  }

  toggleWantsReminders(bool value) {
    emit(
      state.copyWith(
        wantsReminders: value,
      ),
    );
  }

  Future<void> changeProductCamera() async {
    try {
      await loadingImage();
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.copyWith(
            image: imagePicker,
          ),
        );
        await loadingImage();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeProductPhotos() async {
    try {
      await loadingImage();
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
      if (imagePicker != null) {
        emit(
          state.copyWith(
            image: imagePicker,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeReceiptCamera() async {
    try {
      await loadingImage();
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.copyWith(
            receiptImage: imagePicker,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeReceiptPhotos() async {
    try {
      await loadingImage();
      final picker = ImagePicker();
      final imagePicker = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(
          state.copyWith(
            receiptImage: imagePicker,
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            reminderDate: state.reminderDate,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadingImage() async {
    if (state.warrantyState == WarrantyState.loadingImage) {
      return emit(
        state.copyWith(
          warrantyState: WarrantyState.initial,
        ),
      );
    } else {
      return emit(
        state.copyWith(
          warrantyState: WarrantyState.loadingImage,
        ),
      );
    }
  }

  Future<void> submitWarranty() async {
    emit(
      state.copyWith(
        warrantyState: WarrantyState.loading,
      ),
    );
    try {
      await _warrantyRepository.submitWarranty(state);
    } catch (e) {
      log(e.toString());
    }
  }

  void editWarrantyInitial(WarrantyInfo editWarrantyInfo) {
    emit(
      editWarrantyInfo,
    );
    emit(
      state.copyWith(
        warrantyState: WarrantyState.editing,
      ),
    );
  }

  verifyWarranty() {
    if (state.canSave()) {
      return true;
    } else {
      return false;
    }
  }
}
