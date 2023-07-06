import 'package:firebase_core/firebase_core.dart';
import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/domain/user_collection.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'current_warranties_cubit.freezed.dart';
part 'current_warranties_state.dart';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit() : super(const CurrentWarrantiesState.initial());

  Future<void> initialStartUp() async {
    final warrantyCollection = WarrantyCollection();
    final List<WarrantyInfo>? firebaseData = await warrantyCollection.readAll();

    List<WarrantyInfo> initialList;
    List<WarrantyInfo> expiringList;

    //Handles Firebase list to this list
    if (firebaseData != null) {
      initialList = firebaseData;
    } else {
      initialList = List.from(state.warrantyInfoList);
    }
    expiringList = List.from(initialList);

    //Handles ExpiringList
    if (expiringList.any((e) => e.lifeTime)) {
      expiringList.removeWhere((ee) => ee.lifeTime);
    }

    if (expiringList.any(
      (e) => e.endOfWarranty!.difference(DateTime.now()).inDays < 30,
    )) {
      expiringList.removeWhere(
        (ee) =>
            ee.endOfWarranty!.difference(DateTime.now()).inDays > 30 ||
            ee.lifeTime,
      );

      expiringList.sort(
        (a, b) => a.endOfWarranty!.compareTo(
          b.endOfWarranty!,
        ),
      );

      emit(
        state.copyWith(
          warrantyInfoList: initialList,
          expiringList: expiringList,
        ),
      );
    }
  }

  Future<void> addOrEditWarranty(WarrantyInfo warrantyInfo) async {
    final warrantyCollection = WarrantyCollection();

    if (warrantyInfo.warrantyId.isEmpty) {
      warrantyInfo = warrantyInfo.copyWith(
        warrantyId: warrantyCollection.generateDocId().docId,
      );
    }

    final List<WarrantyInfo>? data = await warrantyCollection.readAll();

    List<WarrantyInfo> newList;
    List<WarrantyInfo> expiringList;

    if (data != null) {
      newList = data;
    } else {
      newList = List.from(state.warrantyInfoList);
    }
    expiringList = List.from(state.warrantyInfoList);

    if (expiringList.any((e) => e.warrantyId == warrantyInfo.warrantyId)) {
      expiringList[state.warrantyInfoList
              .indexWhere((e) => e.warrantyId == warrantyInfo.warrantyId)] =
          warrantyInfo;
      emit(
        state.copyWith(
          removeBool: false,
          warrantyInfoList: expiringList,
        ),
      );
    } else {
      expiringList.add(warrantyInfo);
      try {
        await uploadProductFile(
          imagePath: warrantyInfo.image,
          warrantyId: warrantyInfo.warrantyId,
        );

        if (warrantyInfo.receiptImage != null) {
          await uploadReceiptFile(
            imagePath: warrantyInfo.receiptImage,
            warrantyId: warrantyInfo.warrantyId,
          );
        }

        if (warrantyInfo.imageUrl == null) {
          final urlReturn = await downloadProductURL(
            WarrantyCollection.productUrlPath(
              warrantyId: warrantyInfo.warrantyId,
              imagePath: warrantyInfo.image!,
            ),
          );
          warrantyInfo = warrantyInfo.copyWith(
            imageUrl: urlReturn,
          );
        }
        if (warrantyInfo.receiptImage != null &&
            warrantyInfo.receiptImageUrl == null) {
          final urlReturn = await downloadReceiptURL(
            WarrantyCollection.receiptUrlPath(
              warrantyId: warrantyInfo.warrantyId,
              imagePath: warrantyInfo.receiptImage!,
            ),
          );
          warrantyInfo = warrantyInfo.copyWith(
            receiptImageUrl: urlReturn,
          );
        }

        await warrantyCollection.updateOrCreate(
            docId: DocumentId(
              warrantyInfo.warrantyId,
            ),
            value: warrantyInfo);
      } catch (e) {
        debugPrint('ERROR: $e');
        rethrow;
      }
    }

    if (expiringList.any((e) => e.lifeTime)) {
      expiringList.removeWhere((ee) => ee.lifeTime);
    }

    if (expiringList.any(
      (e) => e.endOfWarranty!.difference(DateTime.now()).inDays < 30,
    )) {
      expiringList.removeWhere(
        (ee) =>
            ee.endOfWarranty!.difference(DateTime.now()).inDays > 30 ||
            ee.lifeTime,
      );

      expiringList.sort(
        (a, b) => a.endOfWarranty!.compareTo(
          b.endOfWarranty!,
        ),
      );
      emit(
        state.copyWith(
          expiringList: expiringList,
        ),
      );
    }

    if (newList.any((e) => e.warrantyId == warrantyInfo.warrantyId)) {
      newList[state.warrantyInfoList
              .indexWhere((e) => e.warrantyId == warrantyInfo.warrantyId)] =
          warrantyInfo;
      emit(
        state.copyWith(
          removeBool: false,
          warrantyInfoList: newList,
        ),
      );
    } else {
      newList.add(warrantyInfo);

      emit(
        state.copyWith(
          removeBool: !state.removeBool,
          warrantyInfoList: newList,
        ),
      );
    }
  }

  Future<void> removeWarranty(int index) async {
    final warrantyCollection = WarrantyCollection();

    try {
      await warrantyCollection.delete(
        DocumentId(
          state.warrantyInfoList[index].warrantyId,
        ),
      );
    } catch (e) {
      debugPrint('$e');
    }

    List<WarrantyInfo> removeList;

    removeList = state.warrantyInfoList;

    removeList.removeAt(index);
    emit(
      state.copyWith(
        removeBool: !state.removeBool,
        warrantyInfoList: removeList,
      ),
    );
  }

  Future<void> editWarranty(int index) async {
    NewWarrantyCubit().editWarrantyInitial(
      state.warrantyInfoList[index],
    );
  }
}

Future<void> uploadProductFile({
  required String? imagePath,
  required String warrantyId,
}) async {
  File file = File(imagePath!);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(
          WarrantyCollection.productUrlPath(
            warrantyId: warrantyId,
            imagePath: imagePath,
          ),
        )
        .putFile(file);
  } on FirebaseException catch (e) {
    debugPrint(
      e.toString(),
    );
    // e.g, e.code == 'canceled'
  }
}

Future<void> uploadReceiptFile({
  required String? imagePath,
  required String warrantyId,
}) async {
  File file = File(imagePath!);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(
          WarrantyCollection.receiptUrlPath(
            warrantyId: warrantyId,
            imagePath: imagePath,
          ),
        )
        .putFile(file);
  } on FirebaseException catch (e) {
    debugPrint(
      e.toString(),
    );
    // e.g, e.code == 'canceled'
  }
}

Future<String> downloadProductURL(String path) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref(path)
      .getDownloadURL();

  return downloadURL;

  // Within your widgets:
  // Image.network(downloadURL);
}

Future<String> downloadReceiptURL(String path) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref(path)
      .getDownloadURL();

  return downloadURL;

  // Within your widgets:
  // Image.network(downloadURL);
}
