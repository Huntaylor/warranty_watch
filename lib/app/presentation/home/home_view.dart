import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/home/widgets/expiring_warranty_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(Paths.home.newWarranty.path);
        },
        label: Text(
          context.l10n.newWarrantyBtn,
        ),
      ),
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                context.push(Paths.home.settings.path);
              },
            ),
          ),
        ],
        centerTitle: true,
        title: Center(
          child: Text(
            l10n.mainTitle,
          ),
        ),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
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
              text: context.l10n.currentWarrantyBtn,
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
