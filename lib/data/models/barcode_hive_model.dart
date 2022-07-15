import 'package:barcode_scanner/data/models/barcode.dart';
import 'package:hive/hive.dart';

part 'barcode_hive_model.g.dart';

@HiveType(typeId: 0)
class BarcodeHiveModel extends HiveObject {
  @HiveField(0)
  String barcode;
  @HiveField(1)
  DateTime creationTime;

  BarcodeHiveModel({required this.barcode, required this.creationTime});

  factory BarcodeHiveModel.fromBarcode(Barcode model) => BarcodeHiveModel(
      barcode: model.barcode, creationTime: model.creationTime);
}
