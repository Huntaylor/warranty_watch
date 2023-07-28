import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'warranties_state.dart';
part 'warranties_cubit.g.dart';

class WarrantiesCubit extends Cubit<WarrantiesState> {
  WarrantiesCubit({
    required this.dataRepository,
  }) : super(const _Loading()) {
    getWarranties();
  }
  final DataRepository dataRepository;

  getWarranties() async {
    final list = await dataRepository.getAll();
    emit(
      _Ready(
        warrantyInfo: list,
        expiring: await dataRepository.getAllExpiring(),
        remove: false,
      ),
    );
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
    getWarranties();

    List<WarrantyInfo> newList;
    newList = List.from(state.asReady.warrantyInfo);
    getWarranties();

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
