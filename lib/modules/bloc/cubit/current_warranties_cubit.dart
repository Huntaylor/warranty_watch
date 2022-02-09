import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/modules/bloc/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warrenty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';

part 'current_warranties_cubit.freezed.dart';
part 'current_warranties_state.dart';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit() : super(const CurrentWarrantiesState.initial());

  void addWarranty(WarrantyInfo warrantyInfo) {
    List<WarrantyInfo> newList;
    newList = List.from(state.warrantyInfoList);

    if (newList.any((e) => e.key == warrantyInfo.key)) {
      close();
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

  void saveEdits(WarrantyInfo warrantyInfo) {
    List<WarrantyInfo> newList;
    newList = List.from(state.warrantyInfoList);
    if (newList.any((e) => e.key == warrantyInfo.key)) {
      newList[state.warrantyInfoList
          .indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
      emit(
        state.copyWith(
          removeBool: false,
          warrantyInfoList: newList,
        ),
      );
    } else {
      close();
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
