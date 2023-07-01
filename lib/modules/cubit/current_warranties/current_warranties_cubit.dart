import 'package:bloc/bloc.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'current_warranties_state.dart';
part 'current_warranties_cubit.g.dart';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit() : super(CurrentWarrantiesInitialState(warrantyInfoList: [], expiringList: [], removeBool: ));

  void addOrEditWarranty(WarrantyInfo warrantyInfo) {
    List<WarrantyInfo> newList;
    List<WarrantyInfo> expiringList;
    newList = List.from(state.warrantyInfoList);
    expiringList = List.from(state.warrantyInfoList);

    if (expiringList.any((e) => e.key == warrantyInfo.key)) {
      expiringList[state.warrantyInfoList.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
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
      newList[state.warrantyInfoList.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
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
