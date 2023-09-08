import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
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
              return const LinearProgressIndicator();
            }
            return WarrantiesCardListBuilder(
              title: 'There are no warranties about to expire',
              warranties: state.asReady.expiring,
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
              return const LinearProgressIndicator();
            }
            return WarrantiesCardListBuilder(
              title: 'You currently have no warranties to watch',
              warranties: state.asReady.warranties,
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

class WarrantiesCardListBuilder extends StatelessWidget {
  const WarrantiesCardListBuilder({
    required this.title,
    required this.warranties,
    super.key,
  });

  final String title;
  final List<WarrantyInfo> warranties;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: warranties.isNotEmpty,
      replacement: Text(
        title,
        style: context.textTheme.titleMedium!
            .copyWith(color: context.colorScheme.primary),
      ),
      child: Container(
        height: 215,
        child: ListView.builder(
          itemCount: warranties.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return WarrantyDisplayCard(
              warrantyInfo: warranties[index],
              onSelect: () {},
            );
          },
        ),
      ),
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
