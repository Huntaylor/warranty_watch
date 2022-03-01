import 'package:warranty_keeper/app_library.dart';
import 'package:warranty_keeper/modules/cubit/barcode_scanner/barcode_scanner_cubit.dart';

class BarcodeScannerView extends StatelessWidget {
  static const routeName = '/barcodeScannerView';
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcodeCubit = context.read<BarcodeScannerCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('barcode scanner view'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: barcodeCubit.toggleBarcode,
            child: const Text('Scan'),
          ),
          BlocBuilder<BarcodeScannerCubit, BarcodeScannerState>(
            builder: (context, state) {
              return Text(state.barcodeText);
            },
          ),
        ],
      ),
    );
  }
}
