import 'package:image_picker/image_picker.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
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
  }

  changeEditing() {
    emit(
      state.copyWith(
        isEditing: false,
      ),
    );
  }

  Future<void> changeProductCamera() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicker!.path);
    final savedImage = imagePicker.saveTo('${appDir.path}/$fileName');
    emit(
      state.copyWith(
        image: File(imagePicker.path),
      ),
    );
    NavCubit().pop();
  }

  Future<void> changeProductPhotos() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicker!.path);
    final savedImage = imagePicker.saveTo('${appDir.path}/$fileName');
    emit(
      state.copyWith(
        image: File(imagePicker.path),
      ),
    );
    NavCubit().pop();
  }

  Future<void> changeReceiptCamera() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicker!.path);
    final savedreceiptImage = imagePicker.saveTo('${appDir.path}/$fileName');
    emit(
      state.copyWith(
        receiptImage: File(imagePicker.path),
      ),
    );
    NavCubit().pop();
  }

  Future<void> changeReceiptPhotos() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicker!.path);
    final savedreceiptImage = imagePicker.saveTo('${appDir.path}/$fileName');
    emit(
      state.copyWith(
        receiptImage: File(imagePicker.path),
      ),
    );
    NavCubit().pop();
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
