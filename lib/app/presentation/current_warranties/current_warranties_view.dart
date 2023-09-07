import 'package:warranty_watch/app/app_library.dart';
import 'package:warranty_watch/app/presentation/current_warranties/widgets/current_widget_card.dart';
import 'package:warranty_watch/app/presentation/loading/widgets/triangle_loading_indicator.dart';
import 'package:warranty_watch/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_watch/modules/cubit/warranty_details/warranty_details_cubit.dart';

class CurrentWarrantiesView extends StatelessWidget {
  const CurrentWarrantiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Current Warranties'),
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: BlocBuilder<WarrantiesCubit, WarrantiesState>(
          builder: (context, state) {
            if (state.isError) {
              return const Text('Unable to find warranties');
            } else if (state.isLoading) {
              return const TriangleLoadingIndicator();
            }
            final list =
                context.watch<WarrantiesCubit>().state.asReady.warranties;
            return (list.isEmpty)
                ? Text(context.l10n.noCurrentWarranties)
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return CurrentWidgetCard(
                        onSelect: () {
                          context
                              .read<WarrantyDetailsCubit>()
                              .selectedWarrantyInitial(
                                list[index],
                              );
                          context.push(Paths.home.warranties.details.path);
                        },
                        onEdit: () {
                          // context
                          //     .read<WarrantyCubit>()
                          //     .editWarrantyInitial(list[index]);
                          // context.pushNamed(Paths.home.newWarranty.path);
                        },
                        onRemove: () => context
                            .read<WarrantiesCubit>()
                            .removeWarranty(index),
                        warrantyInfo: list[index],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
