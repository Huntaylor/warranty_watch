import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/widgets/current_widget_card.dart';

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
    final list = context.watch<CurrentWarrantiesCubit>().state.asReady.warrantyInfo;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: BlocBuilder<CurrentWarrantiesCubit, CurrentWarrantiesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else {
              return (list.isEmpty)
                  ? Text(context.appLocalizations.noCurrentWarranties)
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return CurrentWidgetCard(
                          onSelect: () {
                            context.read<WarrantyDetailsCubit>().selectedWarrantyInitial(
                                  list[index],
                                );
                            context.push(Paths.home.warrantyDetails.goRoute);
                          },
                          onEdit: () {
                            context.read<NewWarrantyCubit>().editWarrantyInitial(list[index]);
                            context.pushNamed(Paths.home.newWarranty.goRoute);
                          },
                          onRemove: () => context.read<CurrentWarrantiesCubit>().removeWarranty(index),
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
