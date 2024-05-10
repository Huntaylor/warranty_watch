import 'package:gap/gap.dart';
import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/app/presentation/new_warranties/domain/entities/warranty_info.dart';
import 'package:warranty_watch/app/widgets/warranty_base_view.dart';
import 'package:warranty_watch/app/widgets/warranty_list_card.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';

class UserWarrantiesView extends StatelessWidget {
  const UserWarrantiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarrantiesCubit, WarrantiesState>(
      builder: (context, state) {
        String title;
        switch (state.asReady.warrantiesViewOption) {
          case WarrantiesViewOption.current:
            title = 'Your Warranties';
          case WarrantiesViewOption.expired:
            title = 'Your Expired Warranties';
          case WarrantiesViewOption.expiring:
            title = 'Your Expiring Warranties';
        }
        return WarrantyBaseView(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
          ),
          children: const [
            Gap(16),
            _Content(),
            Gap(16),
          ],
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarrantiesCubit, WarrantiesState>(
      builder: (context, state) {
        if (state.isError) {
          return Text(
            'Unable to find warranties',
            style: context.textTheme.titleMedium!
                .copyWith(color: context.colorScheme.error),
          );
        } else if (state.isLoading) {
          return const TriangleLoadingIndicator();
        }
        var warranties = <WarrantyInfo>[];

        switch (state.asReady.warrantiesViewOption) {
          case WarrantiesViewOption.current:
            warranties = state.asReady.sortedWarranties;
          case WarrantiesViewOption.expired:
            warranties = state.asReady.expired;
          case WarrantiesViewOption.expiring:
            warranties = state.asReady.expiring;
        }

        return (warranties.isEmpty)
            ? Center(
                child: Text(
                  context.l10n.noCurrentWarranties,
                  style: context.textTheme.titleMedium!
                      .copyWith(color: context.colorScheme.primary),
                ),
              )
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: warranties.length,
                itemBuilder: (context, index) {
                  return WarrantyListCard(
                    warrantyInfo: warranties[index],
                  );
                },
              );
      },
    );
  }
}
