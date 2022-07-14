import 'package:barcode_scanner/data/models/barcode.dart';

// ignore: must_be_immutable
class BarcodeModel extends Barcode {
  BarcodeModel({required String barcode, required DateTime creationTime})
      : super(barcode: barcode, creationTime: creationTime);
}
