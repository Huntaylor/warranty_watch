import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranties/warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/widgets/current_widget_card.dart';
import 'package:warranty_keeper/presentation/loading/widgets/triangle_loading_indicator.dart';

class CurrentWarrantiesView extends StatelessWidget {
  const CurrentWarrantiesView({Key? key}) : super(key: key);

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
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = context.watch<WarrantiesCubit>().state.asReady.warrantyInfo;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: BlocBuilder<WarrantiesCubit, WarrantiesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const TriangleLoadingIndicator();
            } else {
              return (list.isEmpty)
                  ? Text(context.appLocalizations.noCurrentWarranties)
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
            }
          },
        ),
      ),
    );
  }
}
