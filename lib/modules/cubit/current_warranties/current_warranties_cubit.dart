import 'package:firebase_core/firebase_core.dart';
import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/domain/user_collection.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'current_warranties_cubit.freezed.dart';
part 'current_warranties_state.dart';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit() : super(const CurrentWarrantiesState.initial());

  Future<void> addOrEditWarranty(WarrantyInfo warrantyInfo) async {
    final warrantyCollection = WarrantyCollection();

    warrantyCollection.stream(
      DocumentId(
        warrantyCollection.path,
      ),
    );

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
          filePath: warrantyInfo.image,
          warrantyId: warrantyInfo.warrantyId.toString(),
        );

        if (warrantyInfo.receiptImage != null) {
          await uploadReciptFile(
            filePath: warrantyInfo.receiptImage,
            warrantyId: warrantyInfo.warrantyId.toString(),
          );
        }

        await warrantyCollection.updateOrCreate(
            docId: DocumentId(
              warrantyInfo.warrantyId.toString(),
            ),
            value: warrantyInfo);
      } catch (e) {
        debugPrint('$e');
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

  void removeWarranty(int index) {
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
    NewWarrantyCubit().editWarrantyInitial(state.warrantyInfoList[index]);
    await NavCubit().appNavigator.pushNamed(NewWarrantyView.routeName);
  }
}

Future<void> uploadProductFile(
    {required String? filePath, required String warrantyId}) async {
  File file = File(filePath!);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('${WarrantyCollection().path}/$warrantyId')
        .putFile(file);
  } on FirebaseException catch (e) {
    debugPrint(e.toString());
    // e.g, e.code == 'canceled'
  }
}

Future<void> uploadReciptFile(
    {required String? filePath, required String warrantyId}) async {
  File file = File(filePath!);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('${WarrantyCollection().path}/$warrantyId')
        .putFile(file);
  } on FirebaseException catch (e) {
    debugPrint(e.toString());
    // e.g, e.code == 'canceled'
  }
}
