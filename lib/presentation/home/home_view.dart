import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/presentation/home/widgets/expiring_warranty_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(Paths.home.newWarranty.path);
        },
        label: Text(
          context.appLocalizations.newWarrantyBtn,
        ),
      ),
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
                    context.push(Paths.home.settings.path);
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
            WarrantyElevatedButton.general(
              isEnabled: true,
              onPressed: () {
                context.push(Paths.home.warranties.path);
              },
              text: context.appLocalizations.currentWarrantyBtn,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
