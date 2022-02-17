import 'package:bloc/bloc.dart';
import 'package:warranty_keeper/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_keeper/utils/unions/url_launch_helper.dart';

class WarrantyDetailsCubit extends Cubit<WarrantyInfo> {
  WarrantyDetailsCubit() : super(WarrantyInfo());

  selectedWarrantyInitial(WarrantyInfo selectedWarranty) {
    emit(selectedWarranty);
  }

  launch(String url) async {
    UrlLaunchHelper.launchURL(url);
  }
}
