import 'dart:developer';

import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warranty_keeper/data/data_sources.dart/firebase_data_source.dart';
import 'package:warranty_keeper/data/models/user_data.dart';
import 'package:warranty_keeper/data/repositories/auth_repository.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'warranties_state.dart';
part 'warranties_cubit.g.dart';

class WarrantiesCubit extends Cubit<WarrantiesState> {
  WarrantiesCubit({
    required this.dataRepository,
    required this.authRepository,
  }) : super(
          const _Loading(),
        ) {
    getInitial();
    dataRepository.warrantiesDataStream.listen(
      (data) {
        emit(
          _Ready(
            warrantyInfo: data ?? [],
            expiring: getExpiring(
              data ?? [],
            ),
          ),
        );
      },
      onError: (e) {
        log('There was a problem with the listener: $e', error: e);
        emit(
          const _Error(),
        );
      },
    );
  }
  final DataRepository dataRepository;
  final AuthRepository authRepository;

  getInitial() async {
    final fbmApi = FirebaseAPI();
    fbmApi.initNotifications;
    final token = await fbmApi.getToken;

    final updateUser = UserData.tokens(tokens: {token!});
    authRepository.updatePersonalData(updateUser);
  }

  getExpiring(List<WarrantyInfo> list) {
    List<WarrantyInfo> expiringList;
    expiringList = List.from(list);
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

    List<WarrantyInfo> newList;
    newList = List.from(state.asReady.warrantyInfo);
    // getWarranties();

    if (newList.any(
      (e) => e.id == warrantyInfo.id,
    )) {
      newList[state.asReady.warrantyInfo.indexWhere(
        (e) => e.id == warrantyInfo.id,
      )] = warrantyInfo;
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
          remove: !state.asReady.remove!,
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
        remove: !state.asReady.remove!,
        warrantyInfo: removeList,
      ),
    );
  }
}
