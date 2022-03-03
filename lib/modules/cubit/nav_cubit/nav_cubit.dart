import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';
import 'package:warranty_keeper/presentation/warranty_details/presentation/warranty_details_view.dart';
import 'package:warranty_keeper/utils/app_navigator.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavInitial());

  final appNavigator = AppNavigator.instance;

  void newWarrNav() {
    appNavigator.pushNamed(
      NewWarrantyView.routeName,
    );
  }

  void pop() {
    appNavigator.pop();
  }

  void currWarrNav() {
    appNavigator.pushNamed(CurrentWarrantiesView.routeName);
  }

  void detailsNav() {
    appNavigator.pushNamed(WarrantyDetailsView.routeName);
  }
}
