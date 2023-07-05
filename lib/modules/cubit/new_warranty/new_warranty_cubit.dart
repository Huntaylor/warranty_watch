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
        warrWebsite: websiteName,
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
        endOfWarr: DateFormat('MM/dd/yyyy').parse(date),
      ),
    );
    changeReminderDate(date);
  }

  changeReminderDate(String date) {
    final daysTill = state.endOfWarr!.difference(DateTime.now()).inDays;
    if (state.reminderDate == null) {
      if (daysTill < 7 && daysTill > 1) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarr!.year,
              state.endOfWarr!.month,
              state.endOfWarr!.day - 2,
            ),
          ),
        );
      } else if (daysTill < 14 && daysTill > 7) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarr!.year,
              state.endOfWarr!.month,
              state.endOfWarr!.day - 7,
            ),
          ),
        );
      } else if (daysTill < 30 && daysTill > 14) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarr!.year,
              state.endOfWarr!.month,
              state.endOfWarr!.day - 14,
            ),
          ),
        );
      } else if (daysTill < 90 && daysTill > 30) {
        return emit(
          state.copyWith(
              reminderDate: DateTime(
            state.endOfWarr!.year,
            state.endOfWarr!.month,
            state.endOfWarr!.day - 30,
          )),
        );
      } else if (daysTill > 90) {
        return emit(
          state.copyWith(
            reminderDate: DateTime(
              state.endOfWarr!.year,
              state.endOfWarr!.month,
              state.endOfWarr!.day - 30,
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
      final savedImage = imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          image: File(imagePicker.path),
        ),
      );
      //nav away
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
      final savedImage = imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          image: File(imagePicker.path),
        ),
      );
      //nav away
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
      final savedreceiptImage = imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          receiptImage: File(imagePicker.path),
        ),
      );
      //nav away
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
      final savedreceiptImage = imagePicker.saveTo('${appDir.path}/$fileName');

      emit(
        state.copyWith(
          receiptImage: File(imagePicker.path),
        ),
      );
      //nav away
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

  newWar() {
    emit(
      WarrantyInfo(),
    );
  }
}
