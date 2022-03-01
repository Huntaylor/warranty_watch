import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/presentation/home/widgets/expiring_warranty_card.dart';
import 'package:warranty_keeper/presentation/settings/settings_view.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/homeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final navCubit = context.read<NavCubit>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton(
              icon: const Icon(
                Icons.menu,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  onTap: () {
                    navCubit.appNavigator.pushNamed(SettingsView.routeName);
                  },
                  child: const Text('Settings'),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: const Text('Help'),
                ),
              ],
            ),
          )
        ],
        centerTitle: true,
        title: Center(
          child: Text(
            appLocalizations.mainTitle,
          ),
        ),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavCubit>();
    final newWarrCubit = context.read<NewWarrantyCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ExpiringWarrantyCard(),
            const SizedBox(
              height: 5,
            ),
            //  Current Warranty
            WarrantyElevatedButton(
              isEnabled: true,
              onPressed: () {
                navCubit.appNavigator
                    .pushNamed(CurrentWarrantiesView.routeName);
              },
              text: context.appLocalizations.currentWarrantyBtn,
            ),
            //  Add Warranty
            WarrantyElevatedButton(
              isEnabled: true,
              onPressed: () {
                newWarrCubit.clear();
                navCubit.newWarrNav();
              },
              text: context.appLocalizations.newWarrantyBtn,
            ),
          ],
        ),
      ),
    );
  }
}
