import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'current_warranties_state.dart';
part 'current_warranties_cubit.g.dart';

// import 'firebase';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit({required this.warrantiesSource}) : super(const _Loading());

  final IWarrantiesSource warrantiesSource;

  void addOrEditWarranty(WarrantyInfo warrantyInfo) async {
    final list = await warrantiesSource.getWarranties();

    List<WarrantyInfo> newList;
    List<WarrantyInfo> expiringList;
    newList = List.from(state.asReady.warrantyInfo);
    expiringList = List.from(state.asReady.warrantyInfo);

    if (expiringList.any((e) => e.key == warrantyInfo.key)) {
      expiringList[state.asReady.warrantyInfo.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
      emit(
        state.copyWith(
          removeBool: false,
          warrantyInfoList: expiringList,
        ),
      );
    } else {
      expiringList.add(warrantyInfo);
    }
    if (expiringList.any((e) => e.lifeTime)) {
      expiringList.removeWhere((ee) => ee.lifeTime);
    }

    if (expiringList.any((e) => e.endOfWarr!.difference(DateTime.now()).inDays < 30)) {
      expiringList.removeWhere((ee) => ee.endOfWarr!.difference(DateTime.now()).inDays > 30 || ee.lifeTime);

      expiringList.sort(
        ((a, b) => a.endOfWarr!.compareTo(b.endOfWarr!)),
      );
      emit(
        state.copyWith(
          expiringList: expiringList,
        ),
      );
    }

    if (newList.any((e) => e.key == warrantyInfo.key)) {
      newList[state.asReady.warrantyInfo.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
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
          removeBool: !state.asReady.remove,
          warrantyInfoList: newList,
        ),
      );
    }
  }

  void removeWarranty(int index) {
    List<WarrantyInfo> removeList;
    removeList = state.asReady.warrantyInfo;
    removeList.removeAt(index);
    emit(
      state.copyWith(
        removeBool: !state.asReady.remove,
        warrantyInfoList: removeList,
      ),
    );
  }

  Future<void> editWarranty(int index) async {
    NewWarrantyCubit().editWarrantyInitial(state.asReady.warrantyInfo[index]);
  }
}

abstract class IWarrantiesSource {
  Future<List<WarrantyInfo>> getWarranties();
}

class WarrantiesSource implements IWarrantiesSource {
  @override
  Future<List<WarrantyInfo>> getWarranties() {
    final list = FireStore;
    //TODO: GET DETAILS FROM FIREBASE

    return list;
  }
}
