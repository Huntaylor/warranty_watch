import 'package:google_fonts/google_fonts.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_display_card.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';

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
        BlocBuilder<WarrantiesCubit, WarrantiesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const TriangleLoadingIndicator();
            }
            return Visibility(
              visible: state.asReady.expiring.isNotEmpty,
              replacement: Text(
                'There are no warranties about to expire',
                style: context.textTheme.titleMedium!
                    .copyWith(color: context.colorScheme.primary),
              ),
              child: ListView.builder(
                itemCount: state.asReady.expiring.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return WarrantyDisplayCard(
                    warrantyInfo: state.asReady.expiring[index],
                    onSelect: () {},
                  );
                },
              ),
            );
          },
        ),
        WarrantiesTitle(
          listTitle: 'Your Warranties',
          onMenu: () {},
        ),

        BlocBuilder<WarrantiesCubit, WarrantiesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const TriangleLoadingIndicator();
            }
            return Visibility(
              visible: state.asReady.expiring.isNotEmpty,
              replacement: Text(
                'You currently have no warranties to watch',
                style: context.textTheme.titleMedium!
                    .copyWith(color: context.colorScheme.primary),
              ),
              child: ListView.builder(
                itemCount: state.asReady.warranties.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return WarrantyDisplayCard(
                    warrantyInfo: state.asReady.warranties[index],
                    onSelect: () {},
                  );
                },
              ),
            );
          },
        ),
        // //  Current Warranty
        // WarrantyElevatedButton.general(
        //   isEnabled: true,
        //   onPressed: () {
        //     context.push(Paths.home.warranties.path);
        //   },
        //   text: context.l10n.currentWarrantyBtn,
        // ),
        const SizedBox(
          height: 5,
        ),
        const WarrantiesTitle(
          listTitle: 'Already Expired',
        ),
      ],
    );
  }
}

class WarrantiesTitle extends StatelessWidget {
  const WarrantiesTitle({
    required this.listTitle,
    this.onMenu,
    super.key,
  });
  final String listTitle;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            listTitle,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox.shrink(),
          Visibility(
            visible: onMenu != null,
            child: Icon(
              Icons.menu,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
