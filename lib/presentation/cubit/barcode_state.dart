part of 'barcode_cubit.dart';

class BarcodeState extends Equatable {
  final List<Barcode> barcodeList;

  const BarcodeState({
    required this.barcodeList,
  });

  @override
  List<Object> get props => [barcodeList];
  BarcodeState copywith({List<Barcode>? barcodeList}) =>
      BarcodeState(barcodeList: barcodeList ?? this.barcodeList);
}
