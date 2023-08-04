import 'dart:developer';

import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'warranty_state.dart';
part 'warranty_cubit.g.dart';

class WarrantyCubit extends Cubit<WarrantyState> {
  //TODO: RENAME TO WARRANTYCUBIT, IT WILL HANDLE CURRENT, SINGULAR, WARRANTIY TO UPDATE, CREATE, AND DELETE ONE
  final DataRepository _dataRepository;
  WarrantyCubit(this._dataRepository)
      : super(
          const _Ready(
            warrantyInfo: WarrantyInfo(id: ''),
          ),
        );

  toggleLifeTime() {
    emit(
      //   _Initial(warrantyInfo: state.asInitial.warrantyInfo.copyWith(
      //   lifeTime: !state.asInitial.warrantyInfo.lifeTime,
      // ),),

      state.asReady.copyWith(
        warrantyInfo: state.asReady.warrantyInfo.copyWith(
          lifeTime: !state.asReady.warrantyInfo.lifeTime,
        ),
      ),
      // state.asInitial.warrantyInfo = state.asInitial.warrantyInfo.copyWith(
      //   lifeTime: !state.asInitial.warrantyInfo.lifeTime,
      // ),
    );
  }

  changePurchaseDate(String date) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        purchaseDate: DateFormat.yMd().parse(date),
      ),
    ));
  }

  changeProductName(String productName) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        name: productName,
      ),
    ));
  }

  changeWebsiteName(String websiteName) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        warrantyWebsite: websiteName,
      ),
    ));
  }

  changeAddtionalDetails(String additionalDetails) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        details: additionalDetails,
      ),
    ));
  }

  changeEndDate(String date) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        endOfWarranty: DateFormat('MM/dd/yyyy').parse(date),
      ),
    ));
    changeReminderDate(date);
  }

  changeReminderDate(String date) {
    final warrantyInfo = state.asReady.warrantyInfo;
    final daysTill =
        warrantyInfo.endOfWarranty!.difference(DateTime.now()).inDays;
    if (warrantyInfo.reminderDate == null) {
      if (daysTill < 7 && daysTill > 1) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                warrantyInfo.endOfWarranty!.year,
                warrantyInfo.endOfWarranty!.month,
                warrantyInfo.endOfWarranty!.day - 2,
              ),
            ),
          ),
        );
      } else if (daysTill < 14 && daysTill > 7) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                warrantyInfo.endOfWarranty!.year,
                warrantyInfo.endOfWarranty!.month,
                warrantyInfo.endOfWarranty!.day - 7,
              ),
            ),
          ),
        );
      } else if (daysTill < 30 && daysTill > 14) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                warrantyInfo.endOfWarranty!.year,
                warrantyInfo.endOfWarranty!.month,
                warrantyInfo.endOfWarranty!.day - 14,
              ),
            ),
          ),
        );
      } else if (daysTill < 90 && daysTill > 30) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                warrantyInfo.endOfWarranty!.year,
                warrantyInfo.endOfWarranty!.month,
                warrantyInfo.endOfWarranty!.day - 30,
              ),
            ),
          ),
        );
      } else if (daysTill > 90) {
        return emit(
          state.asReady.copyWith(
            warrantyInfo: state.asReady.warrantyInfo.copyWith(
              reminderDate: DateTime(
                warrantyInfo.endOfWarranty!.year,
                warrantyInfo.endOfWarranty!.month,
                warrantyInfo.endOfWarranty!.day - 30,
              ),
            ),
          ),
        );
      } else {
        emit(state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            reminderDate: DateFormat('MM/dd/yyyy').parse(date),
          ),
        ));
      }
    }
  }

  toggleWantsReminders(bool value) {
    emit(state.asReady.copyWith(
      warrantyInfo: state.asReady.warrantyInfo.copyWith(
        wantsReminders: value,
      ),
    ));
  }

  Future<void> changeProductCamera() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        emit(state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            image: imagePicker,
          ),
        ));
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
        emit(state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            image: imagePicker,
          ),
        ));
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
        emit(state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            receiptImage: imagePicker,
          ),
        ));
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
        emit(state.asReady.copyWith(
          warrantyInfo: state.asReady.warrantyInfo.copyWith(
            receiptImage: imagePicker,
          ),
        ));
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
    try {
      await _dataRepository.submitWarranty(warrantyDetils);
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  void editWarrantyInitial(WarrantyInfo editWarrantyInfo) {
    emit(
      state.asReady.copyWith(
        warrantyInfo: editWarrantyInfo,
      ),
    );
  }

  verifyWarranty() {
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
