import 'package:firefuel/firefuel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/data/domain/user_collection.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';

part 'current_warranties_cubit.freezed.dart';
part 'current_warranties_state.dart';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit() : super(const CurrentWarrantiesState.initial());

  Future<void> addOrEditWarranty(WarrantyInfo warrantyInfo) async {
    final userColletion = UserCollection();
    final warrantyCollection = WarrantyCollection();

    List<WarrantyInfo> newList;
    List<WarrantyInfo> expiringList;
    newList = List.from(state.warrantyInfoList);
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
        await warrantyCollection.updateOrCreate(
            docId: DocumentId(
              warrantyInfo.warrantyId.toString(),
            ),
            value:
                warrantyInfo /* FirebaseUser(
            warrantyId: warrantyInfo.warrantyId.toString(),
            name: warrantyInfo.name,
            purchaseDate: warrantyInfo.purchaseDate,
            warrWebsite: warrantyInfo.warrWebsite,
            endOfWarr: warrantyInfo.endOfWarr,
            reminderDate: warrantyInfo.reminderDate,
            details: warrantyInfo.details,
            lifeTime: warrantyInfo.lifeTime,
            isEditing: warrantyInfo.isEditing,
            wantsReminders: warrantyInfo.wantsReminders,
          ), */
            );
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
