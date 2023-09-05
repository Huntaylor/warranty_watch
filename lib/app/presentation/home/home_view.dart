import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_display_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return WarrantyBaseView(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Paths.home.newWarranty.path);
        },
        child: const Icon(Icons.add),
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
            l10n.mainTitle.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
        ),
      ),
      children: [
        WarrantiesTitle(
          listTitle: 'About to Expire',
          onMenu: () {},
        ),
        // ListView.builder(itemBuilder: (context, index) {
        //   return WarrantyDisplayCard(warrantyInfo: warranties[i], onSelect: (){});
        // },),
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
    );
  }
}

class WarrantiesTitle extends StatelessWidget {
  const WarrantiesTitle({
    required this.listTitle,
    required this.onMenu,
    super.key,
  });
  final String listTitle;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('About to expire'),
        SizedBox.shrink(),
        Icon(Icons.menu),
      ],
    );
  }
}
