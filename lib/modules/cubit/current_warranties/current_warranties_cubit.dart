import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warranty_keeper/data/interfaces/iwarranties_source.dart';
import 'package:warranty_keeper/data/models/user.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'current_warranties_state.dart';
part 'current_warranties_cubit.g.dart';

// import 'firebase';

class CurrentWarrantiesCubit extends Cubit<CurrentWarrantiesState> {
  CurrentWarrantiesCubit(
    this._authRepository, {
    required this.warrantiesSource,
  }) : super(const _Loading());
  final AuthRepository _authRepository;
  final IWarrantiesSource warrantiesSource;

  @override
  void emit(CurrentWarrantiesState state) async {
    final list = await warrantiesSource.getWarranties(_authRepository.currentUser());

    emit(
      _Ready(
        warrantyInfo: list,
        expiring: getExpiringList(),
        remove: false,
      ),
    );
    super.emit(state);
  }

  getExpiringList() {
    List<WarrantyInfo> expiringList;
    expiringList = List.from(state.asReady.warrantyInfo);
    if (expiringList.any((e) => e.lifeTime)) {
      expiringList.removeWhere((ee) => ee.lifeTime);
    }

    if (expiringList.any((e) => e.endOfWarr!.difference(DateTime.now()).inDays < 30)) {
      expiringList.removeWhere((ee) => ee.endOfWarr!.difference(DateTime.now()).inDays > 30 || ee.lifeTime);

      expiringList.sort(
        ((a, b) => a.endOfWarr!.compareTo(b.endOfWarr!)),
      );
      emit(
        state.asReady.copyWith(
          expiring: expiringList,
        ),
      );
    }
    return expiringList;
  }

  void addOrEditWarranty({required WarrantyInfo warrantyInfo, required User user}) async {
    List<WarrantyInfo> expiringList;

    expiringList = List.from(state.asReady.warrantyInfo);

    if (expiringList.any((e) => e.key == warrantyInfo.key)) {
      expiringList[state.asReady.warrantyInfo.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
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

    if (newList.any((e) => e.key == warrantyInfo.key)) {
      newList[state.asReady.warrantyInfo.indexWhere((e) => e.key == warrantyInfo.key)] = warrantyInfo;
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
