import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/nav_cubit.dart';
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
    final navCubit = BlocProvider.of<NavCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 5,
        ),
        WarrantyElevatedButton(
          isEnabled: true,
          onPressed: navCubit.currWarrNav,
          text: context.appLocalizations.currentWarrantyBtn,
        ),
        WarrantyElevatedButton(
          isEnabled: true,
          onPressed: navCubit.newWarrNav,
          text: context.appLocalizations.newWarrantyBtn,
        ),
      ],
    );
  }
}
