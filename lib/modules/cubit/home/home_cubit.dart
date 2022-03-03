import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState.initial(
              expiringList: CurrentWarrantiesCubit().state.expiringList),
        );
}
