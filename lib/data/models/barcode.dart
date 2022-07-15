import 'package:barcode_scanner/data/models/barcode_hive_model.dart';
import 'package:equatable/equatable.dart';

class Barcode extends Equatable {
  final String barcode;
  final DateTime creationTime;

  const Barcode({required this.barcode, required this.creationTime});

  factory Barcode.fromBarcodeHiveModel(BarcodeHiveModel model) =>
      Barcode(barcode: model.barcode, creationTime: model.creationTime);

  @override
  List<Object?> get props => [barcode, creationTime];
}
