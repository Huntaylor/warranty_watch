import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

class NewWarrantyCubit extends Cubit<WarrantyInfo> {
  NewWarrantyCubit() : super(WarrantyInfo(warrantyId: ''));

  toggleLifeTime() {
    emit(
      state.copyWith(
        lifeTime: !state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarranty: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changePurchaseDate(String date) {
    emit(
      state.copyWith(
        purchaseDate: DateFormat.yMd().parse(date),
        endOfWarranty: state.endOfWarranty,
        lifeTime: state.lifeTime,
        name: state.name,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeProductName(String productName) {
    emit(
      state.copyWith(
        name: productName,
        lifeTime: state.lifeTime,
        purchaseDate: state.purchaseDate,
        endOfWarranty: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeWebsiteName(String websiteName) {
    emit(
      state.copyWith(
        warrantyWebsite: websiteName,
        lifeTime: state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarranty: state.endOfWarranty,
        reminderDate: state.reminderDate,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeAddtionalDetails(String additionalDetails) {
    emit(
      state.copyWith(
        details: additionalDetails,
        lifeTime: state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarranty: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeEndDate(String date) {
    emit(
      state.copyWith(
        endOfWarranty: DateFormat('MM/dd/yyyy').parse(date),
        purchaseDate: state.purchaseDate,
        lifeTime: state.lifeTime,
        name: state.name,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
        wantsReminders: state.wantsReminders,
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
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
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
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
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
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
      } else if (daysTill < 90 && daysTill > 30) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 30,
            ),
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
      } else if (daysTill > 90) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarranty!.year,
              state.endOfWarranty!.month,
              state.endOfWarranty!.day - 30,
            ),
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
      } else {
        emit(
          state.copyWith(
            reminderDate: DateFormat('MM/dd/yyyy').parse(date),
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
      }
    }
  }

  changeEditing(WarrantyState warrantyState) {
    emit(
      state.copyWith(
        warrantyState: warrantyState,
      ),
    );
  }

  toggleWantsReminders(bool value) {
    emit(
      state.copyWith(
        wantsReminders: value,
        lifeTime: state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarranty: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrantyWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        warrantyState: state.warrantyState,
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
        // final appDir = await syspaths.getApplicationDocumentsDirectory();
        // final fileName = path.basename(imagePicker.path);
        // final savedImage = await imagePicker.saveTo('${appDir.path}/$fileName');

        emit(
          state.copyWith(
            image: imagePicker.path,
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            reminderDate: state.reminderDate,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            receiptImage: state.receiptImage,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
          ),
        );
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
        // final appDir = await syspaths.getApplicationDocumentsDirectory();
        // final fileName = path.basename(imagePicker.path);
        // final savedImage = await imagePicker.saveTo('${appDir.path}/$fileName');

        emit(
          state.copyWith(
            image: imagePicker.path,
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarranty: state.endOfWarranty,
            reminderDate: state.reminderDate,
            warrantyWebsite: state.warrantyWebsite,
            details: state.details,
            warrantyState: state.warrantyState,
            wantsReminders: state.wantsReminders,
            receiptImage: state.receiptImage,
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
        // final appDir = await syspaths.getApplicationDocumentsDirectory();
        // final fileName = path.basename(imagePicker.path);
        // final savedreceiptImage =
        //     await imagePicker.saveTo('${appDir.path}/$fileName');

        emit(
          state.copyWith(
            receiptImage: imagePicker.path,
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

  Future<void> changeReceiptPhotos() async {
    try {
      await loadingImage();
      final picker = ImagePicker();
      final imagePicker = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (imagePicker != null) {
        // final appDir = await syspaths.getApplicationDocumentsDirectory();
        // final fileName = '${appDir.absolute}/${imagePicker.path}';
        // final fileName = path.basename(imagePicker.path);
        // final savedreceiptImage =
        //     await imagePicker.saveTo('${appDir.path}/$fileName');

        // savedreceiptImage;

        emit(
          state.copyWith(
            receiptImage: imagePicker.path,
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

  clear() {
    emit(
      WarrantyInfo(warrantyId: ''),
    );
  }
}
