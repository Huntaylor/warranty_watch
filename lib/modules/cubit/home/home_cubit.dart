import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:warranty_keeper/data/repositories/warranty_repository.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';

part 'home_state.dart';
part 'home_cubit.g.dart';

class HomeCubit extends Cubit<HomeState> {
  final DataRepository _dataRepository;
  HomeCubit(this._dataRepository) : super(HomeInitialState()) {
    getInitial();
  }

  getInitial() async {
    final expiring = await _dataRepository.getAllExpiring();

    emit(HomeExpiredLoaded(expiring));
  }
}
