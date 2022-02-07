import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/bloc/cubit/current_warranties_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/widgets/current_widget_card.dart';

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
    final cubitRead = context.read<CurrentWarrantiesCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        child: BlocBuilder<CurrentWarrantiesCubit, CurrentWarrantiesState>(
          builder: (context, state) {
            return (state.warrantyInfoList.isEmpty)
                ? Container(
                    color: Colors.blue,
                    child: const Text('No warranties added'),
                  )
                : ListView.builder(
                    itemCount: state.warrantyInfoList.length,
                    itemBuilder: (context, index) {
                      return CurrentWidgetCard(
                        onEdit: () {
                          cubitRead.editWarranty(index);
                        },
                        onRemove: () => cubitRead.removeWarranty(index),
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
