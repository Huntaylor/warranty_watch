import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'warranties_state.dart';
part 'warranties_cubit.g.dart';

// import 'firebase';

class WarrantiesCubit extends Cubit<WarrantiesState> {
  WarrantiesCubit({
    required this.firebaseDataRepository,
  }) : super(const _Loading()) {
    getWarranties();
  }
  final FirebaseDataRepository firebaseDataRepository;

  getWarranties() async {
    await Future.delayed(const Duration(seconds: 2));
    final list = await firebaseDataRepository.getAll();
    emit(
      _Ready(
        warrantyInfo: list,
        expiring: await getExpiringList(),
        remove: false,
      ),
    );
  }

  getExpiringList() {
    List<WarrantyInfo> expiringList;

    if (state.isLoading) {
      return expiringList = [];
    }

    expiringList = List.from(state.asReady.warrantyInfo);
    if (expiringList.any((e) => e.lifeTime)) {
      expiringList.removeWhere((ee) => ee.lifeTime);
    }

    if (expiringList
        .any((e) => e.endOfWarranty!.difference(DateTime.now()).inDays < 30)) {
      expiringList.removeWhere((ee) =>
          ee.endOfWarranty!.difference(DateTime.now()).inDays > 30 ||
          ee.lifeTime);

      expiringList.sort(
        ((a, b) => a.endOfWarranty!.compareTo(b.endOfWarranty!)),
      );
      emit(
        state.asReady.copyWith(
          expiring: expiringList,
        ),
      );
    }
    return expiringList;
  }

  void addOrEditWarranty({required WarrantyInfo warrantyInfo}) async {
    List<WarrantyInfo> expiringList;

    expiringList = List.from(state.asReady.warrantyInfo);

    if (expiringList.any((e) => e.id == warrantyInfo.id)) {
      expiringList[state.asReady.warrantyInfo
          .indexWhere((e) => e.id == warrantyInfo.id)] = warrantyInfo;
      emit(
        state.asReady.copyWith(
          remove: false,
          warrantyInfo: expiringList,
        ),
      );
    } else {
      expiringList.add(warrantyInfo);
    }
    getExpiringList();

    List<WarrantyInfo> newList;
    newList = List.from(state.asReady.warrantyInfo);
    getExpiringList();

    if (newList.any((e) => e.id == warrantyInfo.id)) {
      newList[state.asReady.warrantyInfo
          .indexWhere((e) => e.id == warrantyInfo.id)] = warrantyInfo;
      emit(
        state.asReady.copyWith(
          remove: false,
          warrantyInfo: newList,
        ),
      );
    } else {
      newList.add(warrantyInfo);

      emit(
        state.asReady.copyWith(
          remove: !state.asReady.remove,
          warrantyInfo: newList,
        ),
      );
    }
  }

  void removeWarranty(int index) {
    List<WarrantyInfo> removeList;
    removeList = state.asReady.warrantyInfo;
    removeList.removeAt(index);
    emit(
      state.asReady.copyWith(
        remove: !state.asReady.remove,
        warrantyInfo: removeList,
      ),
    );
  }
}
