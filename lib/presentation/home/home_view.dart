import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/bloc/cubit/new_warranty/new_warranty_cubit.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit/nav_cubit.dart';
import 'package:warranty_keeper/presentation/current_warranties/current_warranties_view.dart';
import 'package:warranty_keeper/widgets/warranty_button.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/homeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            appLocalizations.mainTitle,
          ),
        ),
      ),
      body: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavCubit>();
    final newWar = BlocProvider.of<NewWarrantyCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 5,
        ),
        //  Current Warranty
        WarrantyElevatedButton(
          isEnabled: true,
          onPressed: () {
            navCubit.appNavigator.pushNamed(CurrentWarrantiesView.routeName);
          },
          text: context.appLocalizations.currentWarrantyBtn,
        ),
        //  Add Warranty
        WarrantyElevatedButton(
          isEnabled: true,
          onPressed: () {
            newWar.clear();
            navCubit.newWarrNav();
          },
          text: context.appLocalizations.newWarrantyBtn,
        ),
      ],
    );
  }
}
