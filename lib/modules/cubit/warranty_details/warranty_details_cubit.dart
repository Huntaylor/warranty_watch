import 'package:bloc/bloc.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warrenty_info.dart';

class WarrantyDetailsCubit extends Cubit<WarrantyInfo> {
  WarrantyDetailsCubit() : super(WarrantyInfo());

  selectedWarrantyInitial(WarrantyInfo selectedWarranty) {
    emit(selectedWarranty);
  }
}
