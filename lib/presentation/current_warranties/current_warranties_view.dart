import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/bloc/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/current_warranties/current_warranties_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/widgets/current_widget_card.dart';
import 'package:warranty_keeper/presentation/new_warranties/presentation/new_warranty_view.dart';

class CurrentWarrantiesView extends StatelessWidget {
  static const routeName = '/currentWarrantiesView';

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
    final currentRead = context.read<CurrentWarrantiesCubit>();
    final navRead = context.read<NavCubit>();
    final newRead = context.read<NewWarrantyCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: BlocBuilder<CurrentWarrantiesCubit, CurrentWarrantiesState>(
          builder: (context, state) {
            return (state.warrantyInfoList.isEmpty)
                ? Text(context.appLocalizations.noCurrentWarranties)
                : ListView.builder(
                    itemCount: state.warrantyInfoList.length,
                    itemBuilder: (context, index) {
                      return CurrentWidgetCard(
                        onEdit: () {
                          newRead.editWarrantyInitial(
                              state.warrantyInfoList[index]);
                          navRead.appNavigator
                              .pushNamed(NewWarrantyView.routeName);
                        },
                        onRemove: () => currentRead.removeWarranty(index),
                        warrantyInfo: state.warrantyInfoList[index],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
