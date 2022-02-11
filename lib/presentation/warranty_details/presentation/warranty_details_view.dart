import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/warranty_details/warranty_details_cubit.dart';

class WarrantyDetailsView extends StatelessWidget {
  static const routeName = '/warrantyDetails';
  const WarrantyDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WarrantyDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('warranty details view'),
        ),
        body: const Center(
          child: Text(
            'this is the warranty details view.',
          ),
        ),
      ),
    );
  }
}
