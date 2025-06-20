import 'dart:async';
import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:warranty_watch/app/data/repositories/auth_repository.dart';
import 'package:warranty_watch/app/data/repositories/warranty_repository.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/utils/data/data_utils.dart';

part 'warranties_cubit.g.dart';
part 'warranties_state.dart';

class WarrantiesCubit extends Cubit<WarrantiesState> {
  WarrantiesCubit({
    required this.dataRepository,
    required this.authRepository,
  }) : super(
          const _Loading(),
        ) {
    bootstrap();
  }
  static final Logger _log = Logger('Warranties Cubit');
  final DataRepository dataRepository;
  final AuthRepository authRepository;

  Future<void> bootstrap() async {
    try {
      dataRepository.warrantiesDataStream.listen(
        (data) {
          _log.info('Positive data response, ${data?.length ?? 0}');
          emit(
            _Ready(
              warranties: data ?? [],
            ),
          );
        },
        onError: (dynamic e) {
          _log.log(
            Level.WARNING,
            'Stream Failure: unable to get warranties',
            e,
          );
        },
      );
    } on Exception catch (e) {
      _log.log(Level.WARNING, 'Stream Try Catch Error', e);
    }
  }

  Future<void> addOrEditWarranty({required WarrantyInfo warrantyInfo}) async {
    List<WarrantyInfo> expiringList;

    expiringList = List.from(state.asReady.warranties);

    if (expiringList.any((e) => e.id == warrantyInfo.id)) {
      expiringList[state.asReady.warranties
          .indexWhere((e) => e.id == warrantyInfo.id)] = warrantyInfo;
    } else {
      expiringList.add(warrantyInfo);
    }

    List<WarrantyInfo> newList;
    newList = List.from(state.asReady.warranties);

    if (newList.any(
      (e) => e.id == warrantyInfo.id,
    )) {
      newList[state.asReady.warranties.indexWhere(
        (e) => e.id == warrantyInfo.id,
      )] = warrantyInfo;
      emit(
        state.asReady.copyWith(
          warranties: newList,
        ),
      );
    } else {
      newList.add(warrantyInfo);

      emit(
        state.asReady.copyWith(
          warranties: newList,
        ),
      );
    }
  }

  void onViewWarranties({required WarrantiesViewOption viewOption}) {
    emit(
      state.asReady.copyWith(
        warrantiesViewOption: viewOption,
      ),
    );
  }

  void swapImages({required bool isProductImage}) {
    emit(
      state.asReady.copyWith(
        isProductImage: isProductImage,
      ),
    );
  }

  void removeWarranty(int index) {
    // TODO(huntaylor): this function doesn't remove the item from the backend
    List<WarrantyInfo> removeList;
    removeList = state.asReady.warranties..removeAt(index);
    emit(
      state.asReady.copyWith(
        warranties: removeList,
      ),
    );
  }

  // Future<void> clearState() async {
  //   emit(
  //     const _Ready(
  //       warranties: [],
  //     ),
  //   );
  // }
}
