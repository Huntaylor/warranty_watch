import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'home_state.dart';
part 'home_cubit.g.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(expiringList: ),
        );
}
