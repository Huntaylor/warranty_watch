part of 'barcode_scanner_cubit.dart';

@freezed
class BarcodeScannerState with _$BarcodeScannerState {
  const factory BarcodeScannerState.initial({
    @Default('') String barcodeText,
  }) = _Initial;
}
