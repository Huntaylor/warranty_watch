import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class NewWarrantyCubit extends Cubit<WarrantyInfo> {
  NewWarrantyCubit() : super(WarrantyInfo());

  toggleLifeTime() {
    emit(
      state.copyWith(
        lifeTime: !state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarr: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changePurchaseDate(String date) {
    emit(
      state.copyWith(
        purchaseDate: DateFormat.yMd().parse(date),
        endOfWarr: state.endOfWarranty,
        lifeTime: state.lifeTime,
        name: state.name,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
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
        endOfWarr: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeWebsiteName(String websiteName) {
    emit(
      state.copyWith(
        warrWebsite: websiteName,
        lifeTime: state.lifeTime,
        name: state.name,
        purchaseDate: state.purchaseDate,
        endOfWarr: state.endOfWarranty,
        reminderDate: state.reminderDate,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
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
        endOfWarr: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
        wantsReminders: state.wantsReminders,
      ),
    );
  }

  changeEndDate(String date) {
    emit(
      state.copyWith(
        endOfWarr: DateFormat('MM/dd/yyyy').parse(date),
        purchaseDate: state.purchaseDate,
        lifeTime: state.lifeTime,
        name: state.name,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
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
            endOfWarr: state.endOfWarranty,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            image: state.image,
            receiptImage: state.receiptImage,
            isEditing: state.isEditing,
            wantsReminders: state.wantsReminders,
          ),
        );
      }
    }
  }

  changeEditing() {
    emit(
      state.copyWith(
        isEditing: false,
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
        endOfWarr: state.endOfWarranty,
        reminderDate: state.reminderDate,
        warrWebsite: state.warrantyWebsite,
        details: state.details,
        image: state.image,
        receiptImage: state.receiptImage,
        isEditing: state.isEditing,
      ),
    );
  }

  Future<void> changeProductCamera() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imagePicker != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imagePicker.path);
      final savedImage = await imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          image: imagePicker.path,
          lifeTime: state.lifeTime,
          name: state.name,
          purchaseDate: state.purchaseDate,
          endOfWarr: state.endOfWarranty,
          reminderDate: state.reminderDate,
          warrWebsite: state.warrantyWebsite,
          details: state.details,
          receiptImage: state.receiptImage,
          isEditing: state.isEditing,
          wantsReminders: state.wantsReminders,
        ),
      );
    }
  }

  Future<void> changeProductPhotos() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imagePicker != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imagePicker.path);
      final savedImage = await imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
            image: imagePicker.path,
            lifeTime: state.lifeTime,
            name: state.name,
            purchaseDate: state.purchaseDate,
            endOfWarr: state.endOfWarranty,
            reminderDate: state.reminderDate,
            warrWebsite: state.warrantyWebsite,
            details: state.details,
            isEditing: state.isEditing,
            wantsReminders: state.wantsReminders,
            receiptImage: state.receiptImage),
      );
    }
  }

  Future<void> changeReceiptCamera() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imagePicker != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imagePicker.path);
      final savedreceiptImage =
          await imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          receiptImage: imagePicker.path,
          lifeTime: state.lifeTime,
          name: state.name,
          purchaseDate: state.purchaseDate,
          endOfWarr: state.endOfWarranty,
          reminderDate: state.reminderDate,
          warrWebsite: state.warrantyWebsite,
          details: state.details,
          image: state.image,
          isEditing: state.isEditing,
          wantsReminders: state.wantsReminders,
        ),
      );
    }
  }

  Future<void> changeReceiptPhotos() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imagePicker != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imagePicker.path);
      final savedreceiptImage =
          await imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          receiptImage: imagePicker.path,
          lifeTime: state.lifeTime,
          name: state.name,
          purchaseDate: state.purchaseDate,
          endOfWarr: state.endOfWarranty,
          reminderDate: state.reminderDate,
          warrWebsite: state.warrantyWebsite,
          details: state.details,
          image: state.image,
          isEditing: state.isEditing,
          wantsReminders: state.wantsReminders,
        ),
      );
    }
  }

  void editWarrantyInitial(WarrantyInfo editWarrantyInfo) {
    emit(
      editWarrantyInfo,
    );
    emit(
      state.copyWith(isEditing: true),
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
      WarrantyInfo(),
    );
  }
}
