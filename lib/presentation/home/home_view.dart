import 'package:go_router/go_router.dart';
import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/presentation/home/widgets/expiring_warranty_card.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    context.push(Paths.home.settings.goRoute);
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
                context.push(Paths.home.currentWarranty.goRoute);
              },
              text: context.appLocalizations.currentWarrantyBtn,
            ),
            const SizedBox(
              height: 5,
            ),
            //  Add Warranty
            WarrantyElevatedButton(
              isEnabled: true,
              onPressed: () {
                newWarrCubit.newWar();
                context.push(Paths.home.newWarranty.goRoute);
              },
              text: context.appLocalizations.newWarrantyBtn,
            ),
          ],
        ),
      ),
    );
  }
}
