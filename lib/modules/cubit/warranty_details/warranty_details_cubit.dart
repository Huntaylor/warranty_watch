import 'package:bloc/bloc.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/utils/unions/url_launch_helper.dart';

class WarrantyDetailsCubit extends Cubit<WarrantyInfo> {
  WarrantyDetailsCubit() : super(const WarrantyInfo(id: ''));

  void selectedWarrantyInitial(WarrantyInfo selectedWarranty) {
    emit(selectedWarranty);
  }

  Future<void> launch(String url) async {
    await UrlLaunchHelper.launchURL(url);
  }
}
