import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barcode_scanner_state.dart';
part 'barcode_scanner_cubit.freezed.dart';

class BarcodeScannerCubit extends Cubit<BarcodeScannerState> {
  BarcodeScannerCubit() : super(BarcodeScannerState.initial());

  Future<void> toggleBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
  }
}
